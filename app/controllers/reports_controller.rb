class ReportsController < ApplicationController
  respond_to :html

  def new
    @report = Report.new zone_id: params[:zone_id]
    render 'zones/index'
  end

  def create
    @report = Report.create params[:report].merge(ip_address: request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip)
    redirect_to root_path anchor: params[:report][:zone_id]
  end
end
