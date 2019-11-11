Rails.application.routes.draw do
  resources :reports
  resources :departments
  resources :stats
  resources :violationtypes
  root to: 'main#index'
  match 'home', to: 'main#index', as: 'home', via: [:get, :post]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  #Lists
  match 'lists', to: 'lists#show_lists', as: 'lists', via: [:get, :post]
  match 'my_lists', to: 'lists#my_lists', as: 'my_lists', via: [:get, :post]
  match 'new_list', to: 'lists#create_lists', as: 'new_list', via: [:get, :post]
  match 'save_list', to: 'lists#save_list', as: 'save_list', via: [:get, :post]
  match 'show_list', to: 'lists#show_list', as: 'show_list', via: [:get, :post]
  match 'refresh_list', to: 'lists#refresh_list', as: 'refresh_list', via: [:get, :post]
  match 'delete_list', to: 'lists#delete_list', as: 'delete_list', via: [:get, :post]
  match 'show_admins', to: 'lists#show_admins', as: 'show_admins', via: [:get, :post]
  match 'change_list_owner', to: 'lists#change_list_owner', as: 'change_list_owner', via: [:get, :post]
  #Covers
  match 'covers', to: 'covers#home', as: 'covers', via: [:get, :post]
  match 'add_cover', to: 'covers#add_manually', as: 'add_cover', via: [:get, :post]
  match 'not_found_covers', to: 'covers#not_found', as: 'not_found_covers', via: [:get, :post]
  match 'new_cover', to: 'covers#new_cover', as: 'new_cover', via: [:get, :post]
  match 'cover_upload', to: 'covers#cover_upload', as: 'cover_upload', via: [:get, :post]
  match 'mark_cover_not_found', to: 'covers#mark_not_found', as: 'mark_cover_not_found', via: [:get, :post]
  match 'load_cover', to: 'covers#load_cover', as: 'load_cover', via: [:get, :post]
  #Reviews
  match 'goodreads', to: 'reviews#goodreads', as: 'goodreads', via: [:get, :post], :defaults => { :format => 'json' }
  #Trailers 
  match 'trailer_queue', to: 'trailers#queue', as: 'trailer_queue', via: [:get, :post]
  match 'trailer_not_found', to: 'trailers#not_found', as: 'trailer_not_found', via: [:get, :post]
  match 'trailer_by_id', to: 'trailers#by_id', as: 'trailer_by_id', via: [:get, :post]
  match 'show_calendar', to: 'reports#show_calendar', as: 'show_calendar', via: [:get, :post], :defaults => { :format => 'js'}
  match 'show_report_form', to: 'reports#show_report_form', as: 'show_report_form', via: [:get, :post], :defaults => { :format => 'js'}
  match 'save_report', to: 'reports#save_report', as: 'save_report', via: [:get, :post], :defaults => { :format => 'js'} 
  #Incidents
  match 'incidents', to: 'incidents#list_incidents', as: 'incidents', via: [:get, :post]
  match 'new_incident', to: 'incidents#new_incident', as: 'new_incident', via: [:get, :post]
  match 'edit_incident', to: 'incidents#edit_incident', as: 'edit_incident', via: [:get, :post]
  match 'currently_suspended', to: 'incidents#currently_suspended', as: 'currently_suspended', via: [:get, :post]
  match 'search_incidents', to: 'incidents#search_incidents', as: 'search_incidents', via: [:get, :post]
  match 'all_patrons', to: 'incidents#all_patrons', as: 'all_patrons', via: [:get, :post]
  match 'edit_patron', to: 'incidents#edit_patron', as: 'edit_patron', via: [:get, :post]
  match 'update_patron', to: 'incidents#update_patron', as: 'update_patron', via: [:get, :post], :defaults => { :format => 'js'}
  match 'delete_patron_pic', to: 'incidents#delete_patron_pic', as: 'delete_patron_pic', via: [:get, :post], :defaults => { :format => 'js'}
  match 'make_primary_patron_pic', to: 'incidents#make_primary_patron_pic', as: 'make_primary_patron_pic', via: [:get, :post], :defaults => {:format => 'js' }
  match 'patron_search', to: 'incidents#patron_search', as: 'patron_search', via: [:get, :post], :defaults => {:format => 'js'}
  match 'save_patron', to: 'incidents#save_patron', as: 'save_patron', via: [:get, :post], :defaults => { :format => 'js'}
  match 'save_incident', to: 'incidents#save_incident', as: 'save_incident', via: [:get, :post], :defaults => { :format => 'js'}
  match 'update_incident', to: 'incidents#update_incident', as: 'update_incident', via: [:get, :post], :defaults => { :format => 'js'}
  match 'delete_incident_pic', to: 'incidents#delete_incident_pic', as: 'delete_incident_pic', via: [:get, :post], :defaults => { :format => 'js'}
  match 'make_primary_incident_pic', to: 'incidents#make_primary_incident_pic', as: 'make_primary_incident_pic', via: [:get, :post], :defaults => {:format => 'js' }
  match 'add_patron_to_incident', to: 'incidents#add_patron_to_incident', as: 'add_patron_to_incident', via: [:get, :post], :defaults => {:format => 'js'}
  match 'save_violations', to: 'incidents#save_violations', as: 'save_violations', via: [:get, :post], :defaults => {:format => 'js'}
  match 'edit_violations', to: 'incidents#edit_violations', as: 'edit_violations', via: [:get, :post], :defaults => {:format => 'js'}
end