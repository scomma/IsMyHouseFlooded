class ZonesController < ApplicationController
  def index
    @zones = Zone.order{updated_at.desc}.all
    @report = Report.new

    headers['Cache-Control'] = 'public, max-age=60'
  end

  def show
    @zone = Zone.includes(:reports).find params[:id]

    headers['Cache-Control'] = 'public, max-age=60'
    render layout: false if request.xhr?
  end

end
