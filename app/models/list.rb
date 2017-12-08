class List < ActiveRecord::Base
	require "addressable/uri"
	require 'httparty'
	belongs_to :admin
	validates :name, presence: true, uniqueness: {message: "A list with this name already exisits"} 
	validates :code, presence: true, uniqueness: {message: "A list with this name already exisits"}

	def check_url
		good_url = false
	 	if  self.url
	 		if self.url.include?'.json'
	 			url = self.url
	 		else
	 			split_url = self.url.split('?')
	 			url = split_url[0] + '.json?' + split_url[1] rescue good_url = false
	 		end
	 		puts url
            if (Addressable::URI.parse(self.url).host == 'catalog.tadl.org' || Addressable::URI.parse(self.url).host == 'catalog.sbbdl.org' || Addressable::URI.parse(self.url).host == 'catalog.apps.tadl.org') && confirm_items(url) == true
	 			good_url = true
	 		else
	 			puts "bad"
	 		end
	 	end
	 	return good_url
	end

	private

	def confirm_items(url)
		response = HTTParty.get(url).parsed_response
		if response['items']
			items = response['items']
		elsif response['list']['items']
			items = response['list']['items']
		end
		if items
			puts "found items"
			check_covers_and_save_to_cache(items) 
			return true
		else
			puts "did not find items"
			return false
		end
	end

	def check_covers_and_save_to_cache(items)
		results_with_images = Array.new
		# See if we are looking at a list or a search
		if self.url.include? 'view_list'
			items_from_catalog = Array.new
			items.each do |i|
				url ='https://catalog.tadl.org/main/details.json?id=' + i['record_id']
				response = HTTParty.get(url).parsed_response
				items_from_catalog.push(response)
			end
			items = items_from_catalog
		end
		items.each do |i|
            url = 'https://catalog.tadl.org/opac/extras/ac/jacket/medium/r/' + i['id'].to_s
            image = MiniMagick::Image.open(url) rescue nil 
            if image != nil
                if image.width > 2
                    results_with_images.push(i)
                end
            end
            if !image.nil?
              image.destroy!
            end
        end
        self.updated_at = Time.now
        self.save
        Rails.cache.write(self.code, results_with_images)
	end

end
