class DevicesController < ApplicationController
  
  require 'rubygems'
  require 'google_geocode'
  
  # GET /devices
  # GET /devices.xml
  def index
    @devices = Device.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @devices }
    end
  end

  # GET /devices/1
  # GET /devices/1.xml
  def show

    @device = Device.find(params[:id])
    @report_id = Report.last(:conditions => {:device_id => @device.id})
    @report = ReportField.all(:conditions => {:report_id => @report_id.id})

    gg = GoogleGeocode.new "ABQIAAAAeSgpsuI2BCtpNLyED8LDQBT2yXp_ZAY8_ufC3CFXhHIE1NvwkxRnm97MQYcMTzXsEX4lf8tuo6XmWA"           
    @map = GMap.new("map_div")                                                                                                
    @map.control_init(:small => true, :large_map => true)                      
    @map.center_zoom_init([56.3, 32],7)                                                                                        
    @map.overlay_init(GMarker.new([56.3, 32],:title => @device.device_code, :info_bubble => 'ConnectPort X4'))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @device }
    end
  end

  # GET /devices/new
  # GET /devices/new.xml
  def new
    @device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @device }
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.xml
  def create
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        flash[:notice] = 'Device was successfully created.'
        format.html { redirect_to(@device) }
        format.xml  { render :xml => @device, :status => :created, :location => @device }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.xml
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        flash[:notice] = 'Device was successfully updated.'
        format.html { redirect_to(@device) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.xml
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to(devices_url) }
      format.xml  { head :ok }
    end
  end
end
