class DevicesController < ApplicationController
  
  # GET /devices
  def index
    @devices = Device.all
    if params[:ajax]
      render :template => "devices/_devices.html.erb", :locals => {:devices => @devices}, :layout => false
    end
  end

  # GET /devices/1
  def show

    @device = Device.find params[:id]
    @report = @device.reports.last
    @fields = @report.fields.all :order => 'key'
    
    if params[:ajax]
      render :template => "reports/_fields.html.erb", :locals => {:fields => @fields}, :layout => false
    else
      #gg = GoogleGeocode.new "ABQIAAAAeSgpsuI2BCtpNLyED8LDQBT2yXp_ZAY8_ufC3CFXhHIE1NvwkxRnm97MQYcMTzXsEX4lf8tuo6XmWA"
      @map = GMap.new "map_div"
      @map.control_init :small => true, :large_map => true, :map_type => true
      
      geo_point =  [ @report['latitude'], @report['longitude'] ]
      @map.center_zoom_init geo_point, 6

      marker = GMarker.new geo_point, :title => @device.device_code, :info_window => '<b>ConnectPort X4</b>'
      @map.overlay_init marker
    end
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
