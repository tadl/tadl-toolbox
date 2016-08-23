class Cover < ActiveRecord::Base
	attr_accessor :coverart_upload_width, :coverart_upload_height
	require 'open-uri'
    require 'mini_magick'
    require 'carrierwave/orm/activerecord'
	validates_uniqueness_of :record_id
	mount_uploader :coverart, CoverartUploader
	validate :check_coverart_dimensions, if :uploading?

	def uploading?
  		coverart_upload_width.present? && coverart_upload_height.present?
	end

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

	def check_coverart_dimensions
		if !coverart_upload_height.nil? && coverart_upload_height > 150
    		errors.add :coverart, "Image must be at least 400px in height" 
  		end
  	end

end
end