ActionController::Routing::Routes.draw do |map|
  map.resources :reports

  map.resources :devices do |device|
    device.resources :reports
  end

 
  map.home '/', :controller => 'devices', :action => 'index'
end
