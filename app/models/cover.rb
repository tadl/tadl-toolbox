class Cover < ActiveRecord::Base
	attr_accessor :coverart_upload_width, :coverart_upload_height
	require 'open-uri'
    require 'mini_magick'
    require 'carrierwave/orm/activerecord'
    require 'open-uri'
    require 'json'
	validates_uniqueness_of :record_id
	mount_uploader :coverart, CoverartUploader
	validate :check_coverart_dimensions, if :uploading? 
	   def uploading?
  		    coverart_upload_width.present? && coverart_upload_height.present?
	   end
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
		if !coverart_upload_height.nil? && coverart_upload_height < 400 
    		errors.add :coverart, "Image must be at least 400px in height" 
  		end
  	end

    def manual_load(record_id)
        url = 'http://mr-v2.catalog.tadl.org/osrf-gateway-v1?service=open-ils.search&method=open-ils.search.biblio.record.mods_slim.retrieve&locale=en-US&param=' + record_id.to_s
        record_info = JSON.parse(open(url).read)
        if !record_info['payload'][0]['textcode']
            self.record_id = record_info['payload'][0]['__p'][2]
            self.title = record_info['payload'][0]['__p'][0]
            self.artist = record_info['payload'][0]['__p'][1]
            self.publisher = record_info['payload'][0]['__p'][6]
            self.release_date = record_info['payload'][0]['__p'][4]
            self.item_type = record_info['payload'][0]['__p'][9][0]
            self.abstract = record_info['payload'][0]['__p'][13]
            self.track_list = record_info['payload'][0]['__p'][15]
            return true
        else
            return false
        end
    end
end