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
            matches = ['/covers']
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
end
