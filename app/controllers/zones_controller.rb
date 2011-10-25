class ZonesController < ApplicationController
  def index
    @zones = Zone.order{updated_at.desc}.where{reports_count > 2}.all
    @report = Report.new

    if params[:format] == 'json'
      headers['Cache-Control'] = 'public, max-age=5'
      render json: @zones.as_json
      
    else
      headers['Cache-Control'] = 'public, max-age=60'
    end
  end

  def show
    @zone = Zone.includes(:reports).find params[:id]

    if params[:format] == 'partial' or request.xhr?
      # headers['Cache-Control'] = 'public, max-age=30'
      render layout: false

    elsif params[:format] == 'json'
      # headers['Cache-Control'] = 'public, max-age=5'
      render json: @zone.as_json(include: {reports: {except: [:ip_address, :author, :updated_at, :zone_id]}})

    else
      # headers['Cache-Control'] = 'public, max-age=30'
    end
  end

end
