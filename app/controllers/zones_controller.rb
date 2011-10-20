class ZonesController < ApplicationController
  def index
    @zones = Zone.all
  end

end
