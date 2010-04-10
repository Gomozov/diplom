class DevicesController < ApplicationController
  
  # GET /devices
  def index
    @devices = Device.all
    if params[:ajax]
      render :action => "index_ajax", :layout => nil
    end
  end

  # GET /devices/1
  def show

    @device = Device.find(params[:id])
    @report_id = Report.last(:conditions => {:device_id => @device.id})
    @report = ReportField.all(:conditions => {:report_id => @report_id.id})
    @report = @report.sort_by { |t| t.key }
    @lat = ReportField.find(:first, :conditions => {:report_id => @report_id.id, :key => 'latitude'})
    @lon = ReportField.find(:first, :conditions => {:report_id => @report_id.id, :key => 'longitude'})
    @temperature = ReportField.find(:first, :conditions => {:report_id => @report_id.id, :key => 'temperature'})

    #gg = GoogleGeocode.new "ABQIAAAAeSgpsuI2BCtpNLyED8LDQBT2yXp_ZAY8_ufC3CFXhHIE1NvwkxRnm97MQYcMTzXsEX4lf8tuo6XmWA"
    @map = GMap.new("map_div")                                                                                                
    @map.control_init(:small => true, :large_map => true, :map_type => true)
    @map.center_zoom_init([@lat.value, @lon.value],6)                                                                                        
    @map.overlay_init(GMarker.new([@lat.value, @lon.value],:title => @device.device_code, :info_window => '<b>ConnectPort X4</b>'))
    
    if params[:ajax]
      render :action => "show_ajax", :layout => nil
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
