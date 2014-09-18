class ServersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @servers  = Server.all
  end

  def show
    @servers  = Server.all
    @server   = Server.find(params[:id])

    @services = { one: [], two: [], three: [] }
    @server.services.order_by(order_column: :asc, order_row: :asc).each do |service|
      case service.order_column
        when 1
          @services[:one] << service
        when 2
          @services[:two] << service
        when 3
          @services[:three] << service
      end
    end
  end
end
