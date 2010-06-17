class DevicesController < ApplicationController
  
  # GET /devices
  def index
    @devices = Device.all

    @map = GMap.new "map_div"
    @map.control_init :small => true, :large_map => true, :map_type => true
    @map.center_zoom_init [54.35 ,48.6], 6
    @devices.each do |d|
      @last_report = d.reports.last
      geo_point =  [ @last_report['latitude'], @last_report['longitude'] ]
      marker = GMarker.new geo_point, :title => d.device_code, :info_window => '<b>Устройство: </b>'+d.device_code+'<br> <b>Статус: </b> <img src="/images/'+d.device_status+'_m.png">'
      @map.overlay_init marker
    end
    #@map.icon_global_init(GIcon.new(:image => '/images/sun.png', :icon_size => GSize.new(32,32), :icon_anchor => GPoint.new(16,32)), 'Sun_icon' )
    #Sun_icon = Variable.new('Sun_icon')
    #sun = GMarker.new([54, 48], :icon => 'Sun_icon')
    #@map.declare_init(sun,'sun')
    #@map.overlay_init sun

    if params[:ajax]
      render :template => "devices/_devices.html.erb", :locals => {:devices => @devices}, :layout => false
    end
  end

  # GET /devices/1
  def show

    @device = Device.find params[:id]
    @last_report = @device.reports.last
    @fields = @last_report.fields
    
    @map = GMap.new "map_div"
    @map.control_init :small => true, :large_map => true, :map_type => true
    
    geo_point =  [ @last_report['latitude'], @last_report['longitude'] ]
    @map.center_zoom_init geo_point, 6

    marker = GMarker.new geo_point, :title => @device.device_code, :info_window => '<b>Устройство: </b>ConnectPort X4<br> <b>Статус: </b> <img src="/images/'+@device.device_status+'_m.png">'
    @map.overlay_init marker
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find params[:id]
  end

  # PUT /devices/1
  def update
    @device = Device.find params[:id]

      if @device.update_attributes params[:device]
        flash[:notice] = 'Device was successfully updated.'
        redirect_to devices_url
      else
        render :action => "edit"
      end
  end

  # DELETE /devices/1
  def destroy
    @device = Device.find params[:id]
    @device.destroy
    redirect_to devices_url
  end
  
end
