class ServicesController < ApplicationController
  def show
    @service = Portlet.find(params[:id])
  end
end
