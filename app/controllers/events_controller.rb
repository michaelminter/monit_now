class EventsController < ApplicationController
  def index
    @events = Server.find(params[:server_id]).events.order_by(:created_at.desc)
  end
end
