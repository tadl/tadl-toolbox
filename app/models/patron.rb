class Patron < ActiveRecord::Base
  include PgSearch::Model
  pg_search_scope :search_by_name_alias, 
                  against: [:first_name, :last_name, :middle_name, :alias],
                  using: {
                    tsearch: {prefix: true}
                  }
  mount_uploaders :patronpic, PatronPicUploader
  has_many :violations

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



end
