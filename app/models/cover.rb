class Cover < ActiveRecord::Base
	require 'open-uri'
    require 'mini_magick'
    require 'carrierwave/orm/activerecord'
	validates_uniqueness_of :record_id
	validates :validate_minimum_image_size
	mount_uploader :coverart, CoverartUploader

	def check_for_cover(record_id)
        url = 'https://catalog.tadl.org/opac/extras/ac/jacket/medium/r/' + record_id.to_s
        image = MiniMagick::Image.open(url) rescue nil
        if image != nil && image.width > 2
        	image.destroy!
        	return true
     	else
     		if image != nil
     			image.destroy!
     		end 
        	return false
        end
	end




  	def validate_minimum_image_size
    	image = MiniMagick::Image.open(coverart.path)
    	unless image[:width] > 1400 && image[:height] > 400
      		errors.add :image, "should be 400x400px minimum!" 
    	end
  	end
end
