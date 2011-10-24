class ZonesController < ApplicationController
  def index
    @zones = Zone.order{updated_at.desc}.where{reports_count > 1}.all
    @report = Report.new
  end

  def show
    @zone = Zone.find params[:id]
  end

end
