class PagesController < ApplicationController
  def show
    render params[:id], layout: if request.xhr? || params[:format] == 'partial' then false else true end
  end
end
