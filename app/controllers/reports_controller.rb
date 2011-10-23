class ReportsController < ApplicationController
  respond_to :html

  def new
    @report = Report.new zone_id: params[:zone_id]
    render 'zones/index'
  end

  def create
    @report = Report.create params[:report].merge(ip_address: request.env['REMOTE_ADDR'])
    redirect_to zones_path
  end

  def show
    @report = Report.find params[:id]
    redirect_to zones_path anchor: "zone_%d" % @report.zone_id
  end
end
