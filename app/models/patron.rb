class Patron < ActiveRecord::Base
  include PgSearch::Model
  pg_search_scope :search_by_name_alias, 
                  against: [:first_name, :last_name, :middle_name, :alias],
                  using: {
                    tsearch: {prefix: true}
                  }
  mount_uploaders :patronpic, PatronPicUploader
  has_many :violations
  has_many :incidents, through: :violations
  has_one :suspension

  def full_name
    if self.no_name == false
      full_name = ''
      full_name += self.first_name unless self.first_name.nil?
      full_name += ' ' + self.middle_name unless self.middle_name.nil?
      full_name += ' ' + self.last_name unless self.last_name.nil?
    else
      full_name = self.alias
    end
  end

  def primary_pic_small
    if self.patronpic.size != 0
      url = self.patronpic[0].small.url
    end
  end

  def other_pics
   if self.patronpic.size >= 1
      pics = self.patronpic
      pics.shift 
      return pics
    end
  end

  def full_address
    if self.no_address == false && self.no_name == false
      full_address = ''
      full_address += self.address unless self.address.nil?
      full_address += ', ' + self.city unless self.city.nil?
      full_address += ' ' + self.state unless self.state.nil?
      full_address += ' ' + self.zip.to_s unless self.zip.nil?
    else
      return 'No known address or homeless'
    end
  end

  def patronpic=(patronpic)
    pics_to_append = patronpic.map do |pic|
      uploader = PatronPicUploader.new(self)
      uploader.store! pic
      uploader
    end
    self[:patronpic] ||= []
    self[:patronpic] += pics_to_append.map {|uploader| uploader.file.filename}
  end

  def delete_patron_pic(index)
    pics_to_keep = self[:patronpic]
    if index == 0 && self.patronpic.size == 1
      self.remove_patronpic!
    else
       deleted_image = pics_to_keep.delete_at(index) 
       deleted_image.try(:remove!)
       self[:patronpic] = pics_to_keep
     end
  end

  def make_primary_patron_pic(index)
    target_pic = self[:patronpic][index]
    self[:patronpic].delete(target_pic)
    self[:patronpic].unshift(target_pic)
  end


  def suspended?
    if !self.suspension.nil? && self.suspension.end_date > Date.today
      return true
    else
      return false
    end
  end

  def generate_suspension
    if self.violations.count == 0 && self.suspension
      self.suspension.delete
      return
    end

    violations = self.violations.joins(:violationtype)

    if !violations.nil?
      not_none_violations = violations.where.not('violationtypes.track = ?', 'None')
      latest_violation = not_none_violations.order('date_issued').last
    end

    if !self.suspension.nil? && self.suspension.end_date >= (Date.today - 2.years)
      violations_a = violations.where('violationtypes.track = ? AND date_issued >= ?', 'A', (latest_violation.date_issued - 2.years))
      violations_b = violations.where('violationtypes.track = ? AND date_issued >= ?', 'B', (latest_violation.date_issued - 2.years))
      suspension.violations_from_date = latest_violation.date_issued - 2.years
      suspension = self.suspension
    elsif !self.suspension.nil? && self.suspension.end_date <= (Date.today - 2.years)
      violations_a = violations.where('violationtypes.track = ?', 'A')
      violations_b = violations.where('violationtypes.track = ?', 'B')
      self.suspension.delete!
      suspension = Suspension.new
      suspension.patron_id = self.id
    elsif not_none_violations.count >= 1
      violations_a = violations.where('violationtypes.track = ?', 'A')
      violations_b = violations.where('violationtypes.track = ?', 'B')
      suspension = Suspension.new
      suspension.patron_id = self.id
    end

    if suspension
      violations_a_count = (violations_a.uniq{|v| v.incident.id}).count
      violations_b_count = (violations_b.uniq{|v| v.incident.id}).count

      last_violation_a_date = Incident.find((violations_a.uniq{|v| v.incident.id}).order('date_issued').last.incident_id).date_of rescue nil
      last_violation_b_date = Incident.find((violations_b.uniq{|v| v.incident.id}).order('date_issued').last.incident_id).date_of rescue nil

      if violations_a_count == 0
        a_suspension = 0.days
      elsif violations_a_count == 1
        a_suspension = 6.months
      elsif violations_a_count > 1
        a_suspension = 1.year
      end

      if violations_b_count == 0
        b_suspension = 0.days
      elsif violations_b_count == 1
        test_for_plus = false
        violations_b.each do |v|
          if (v.violationtype.description[0,2] == 'B1') || (v.violationtype.description[0,2] == 'B2')
            test_for_plus = true
          end
        end
        if test_for_plus
          b_suspension = 1.week
        else
          b_suspension = 1.day
        end
      elsif violations_b_count == 2
        b_suspension = 1.month
      elsif violations_b_count > 2
        b_suspension = 1.year
      end

      if !last_violation_a_date.nil?
        a_suspension_end_date = last_violation_a_date + a_suspension
      end

      if !last_violation_b_date.nil?
        b_suspension_end_date = last_violation_b_date + b_suspension
      end

      if a_suspension_end_date && b_suspension_end_date
        if a_suspension_end_date >= b_suspension_end_date
          suspension.end_date = a_suspension_end_date
          suspension.track = 'A'
        elsif a_suspension_end_date <= b_suspension_end_date
          suspension.end_date = b_suspension_end_date
          suspension.track = 'B'
        end
      elsif a_suspension_end_date
        suspension.end_date = a_suspension_end_date
        suspension.track = 'A'
      elsif b_suspension_end_date
        suspension.end_date = b_suspension_end_date
        suspension.track = 'B'
      end

      suspension.save!
    end

  end

  def last_violation
    violations = self.violations.joins(:violationtype)
    not_none_violations = violations.where.not('violationtypes.track = ?', 'None')
    latest_violation = not_none_violations.order('date_issued').last
    return latest_violation
  end

  def last_incident
    last_incident = Incident.find(last_violation.incident_id)
    return last_incident
  end

  def last_incident_violations
    last_violation = self.last_violation
    last_incident = Incident.find(last_violation.incident_id)
    return last_incident.violations.where(patron_id: self.id)
  end

  def suspension_from_multiple_incidents
    violations = self.violations.joins(:violationtype)
    not_none_violations = violations.where.not('violationtypes.track = ?', 'None')
    if !self.suspension.violations_from_date.nil?
      violations = not_none_violations.where('date_issued >= ? AND incident_id != ?', self.suspension.violations_from_date, self.last_violation.incident_id)
    else
      violations = not_none_violations.where('incident_id != ?', self.last_incident.id)
    end
    return violations
  end

  def unique_incidents
    incidents = self.incidents.select("DISTINCT ON (incidents.id) incidents.*")
    return incidents
  end

  def as_json(options={})
    super(
      :except => [:created_at, :updated_at],
      :include => {
        :suspension => {:only => [:end_date]},
        :violations => {
          :only => [:date_issued, :incident_id],
          :methods => [:violation_description, :incident_title],
        },
      }
    )
  end


end
