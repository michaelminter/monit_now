class ServerController < ApplicationController
  def show
    @servers = Server.all
    @server = Server.find(params[:id])
    @services = @server.services.distinct(:@name)
  end
end
