class EventsController < ApplicationController
  def index
    @events = Server.find(params[:server_id]).events
  end
end
