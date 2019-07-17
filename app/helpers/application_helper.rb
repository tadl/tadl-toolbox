module ApplicationHelper
	def active_tab(link_path)
    	active = current_page?(link_path) ? "active" : ""
	end
	def active_menu(item)
		active = ''
		if item == 'home'
    		matches = ['/home','/']
    	elsif item == 'lists'
    		matches = ['/lists','/new_list','/my_lists','/show_list']
        elsif item == 'covers'
          matches = ['/covers','/not_found_covers','/add_cover']
        elsif item == 'trailers'
          matches = ['/trailer_queue','/trailer_not_found','/trailer_by_id']
        elsif item == 'reports'
          matches = ['/reports']
        elsif item == 'departments'
          matches = ['/departments','/departments/new']
        elsif item == 'stats'
          matches = ['/stats','/stats/new']
        elsif item == 'violationtypes'
          matches = ['/violationtypes','/violationtypes/new']
        elsif item == 'incidents'
          matches = ['/incidents','/new_incident']
    	 else
    		return ''
    	end
    	matches.each do |m|
    		if current_page?(m)
    			active = 'active'
    		end
    	end
    	return active
	end
    
    def find_admin(admin_id)
        admin = Admin.find(admin_id)
        admin_name = admin.name
        return admin_name
    end
end
