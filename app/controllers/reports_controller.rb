class ReportsController < ApplicationController
  before_filter :load_zones
  respond_to :html

  def new
    @report = Report.new
  end

  def create
    @report = Report.create params[:report]
    respond_with @report
  end

  def show
    @report = Report.find params[:id]
    redirect_to zones_path anchor: "zone_%d" % @report.zone_id
  end

  private
    def load_zones
      @zones = Zone.all
    end
end
