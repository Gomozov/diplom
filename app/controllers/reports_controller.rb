class ReportsController < ApplicationController

  # GET /reports/1
  def show
    @report = if params[:device_id] && params[:id] == 'last'
      Device.find(params[:device_id]).reports.last
    else
      Report.find params[:id]
    end
    
    @fields = @report.fields

    respond_to do |format|
      format.html
      format.json do
        render :json => Hash[@fields.map{|f| [f.key, f.value]}]
      end
    end
  end

  # POST /reports
  def create
    @device_code = params[:report].delete(:device_code)
    @device = Device.find_or_create_by_code @device_code
    @report = Report.new params[:report].merge(:device_id => @device.id)

    if @report.save
      flash[:notice] = 'Report was successfully created.'
      render :text => '', :status => 200
    else
      render :text => '', :status => 500
    end
  end

  # DELETE /reports/1
  def destroy
    @report = Report.find params[:id]
    @report.destroy

    redirect_to reports_url
  end
end
