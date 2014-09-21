class EventsController < ApplicationController
  def index
    @server = Server.find params[:server_id]
    @events = @server.events.order_by(:created_at.desc)
  end
end
