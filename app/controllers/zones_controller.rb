class ZonesController < ApplicationController
  def index
    @zones = Zone.order{reports_count.desc}.all
    @report = Report.new
  end

end
