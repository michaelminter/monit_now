class ServersController < ApplicationController
  def index
    @servers  = Server.all
  end

  def show
    @servers  = Server.all
    @server   = Server.find(params[:id])
    @services = @server.services
  end
end
