class ReportsController < ApplicationController
  respond_to :html

  def new
    @report = Report.new zone_id: params[:zone_id]
    render 'zones/index'
  end

  def create
    @report = Report.create params[:report].merge(ip_address: request.env['REMOTE_ADDR'])
    redirect_to root_path # anchor: "zone_%d" % params[:report][:zone_id]
  end
end
