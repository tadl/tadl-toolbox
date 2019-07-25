class Incident < ActiveRecord::Base
  mount_uploaders :incidentpic, IncidentpicUploader
  has_many :violations

  def primary_pic_small
    if self.incidentpic.size != 0
      url = self.incidentpic[0].small.url
    end
  end

  def other_pics
   if self.incidentpic.size >= 1
      pics = self.incidentpic
      pics.shift 
      return pics
    end
  end

  def incidentpic=(incidentpic)
    pics_to_append = incidentpic.map do |pic|
      puts "got one"
      uploader = IncidentpicUploader.new(self)
      uploader.store! pic
      uploader
    end
    self[:incidentpic] ||= []
    self[:incidentpic] += pics_to_append.map {|uploader| uploader.file.filename}
  end

  def delete_incident_pic(index)
    pics_to_keep = self[:incidentpic]
    if index == 0 && self.incidentpic.size == 1
      self.remove_incidentpic!
    else
       deleted_image = pics_to_keep.delete_at(index) 
       deleted_image.try(:remove!)
       self[:incidentpic] = pics_to_keep
     end
  end

  def make_primary_incident_pic(index)
    target_pic = self[:incidentpic][index]
    self[:incidentpic].delete(target_pic)
    self[:incidentpic].unshift(target_pic)
  end
end
