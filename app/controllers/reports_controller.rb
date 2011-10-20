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
    redirect_to zones_path(anchor: "zone_%d" % params[:id])
  end

  private
    def load_zones
      @zones = Zone.all
    end
end
