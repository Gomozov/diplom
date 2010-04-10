class ReportsController < ApplicationController
  # GET /reports
  def index
    @reports = Report.all
  end

  # GET /reports/1
  def show
    @report = Report.find params[:id]
  end

  # POST /reports
  def create
    @device_code = params[:report].delete(:device_code)
    @device = Device.find_or_create_by_code @device_code
    @report = Report.new params[:report].merge(:device_id => @device.id)

    if @report.save
      flash[:notice] = 'Report was successfully created.'
      redirect_to @report
    else
      render :action => "new"
    end
  end

  # DELETE /reports/1
  def destroy
    @report = Report.find params[:id]
    @report.destroy

    redirect_to reports_url
  end
end
