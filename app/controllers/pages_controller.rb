class PagesController < ApplicationController
  def show
    headers['Cache-Control'] = 'public, max-age=300'
    render params[:id], layout: if request.xhr? || params[:format] == 'partial' then false else true end
  end
end
