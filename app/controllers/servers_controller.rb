class ServersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @servers  = Server.all
  end

  def show
    @servers  = Server.all
    @server   = Server.find(params[:id])

    @services = { one: [], two: [], three: [] }
    count = 1
    @server.services.each do |service|
      case count
        when 1
          @services[:one] << service
          count = count + 1
        when 2
          @services[:two] << service
          count = count + 1
        when 3
          @services[:three] << service
          count = 1
      end
    end
    p @services
  end
end
