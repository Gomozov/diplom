ActionController::Routing::Routes.draw do |map|
  map.resources :reports

  map.resources :devices

 
  map.home '/', :controller => 'devices', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
