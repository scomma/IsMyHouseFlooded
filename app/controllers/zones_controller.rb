class ZonesController < ApplicationController
  def index
    @zones = Zone.order{updated_at.desc}.all
    @report = Report.new
  end

end
