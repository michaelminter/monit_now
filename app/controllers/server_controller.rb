class ServerController < ApplicationController
  def show
    @servers  = Server.all
    @server   = Server.find(params[:id])
    @services = @server.services
  end
end
