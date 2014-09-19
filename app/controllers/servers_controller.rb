class ServersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @servers  = Server.all
  end

  def show
    @servers  = Server.all
    @server   = Server.find(params[:id])

    @portlets = { one: [], two: [], three: [] }
    @server.portlets.order_by(order_column: :asc, order_row: :asc).each do |portlet|
      case portlet.order_column
        when 1
          @portlets[:one] << portlet
        when 2
          @portlets[:two] << portlet
        when 3
          @portlets[:three] << portlet
      end
    end
  end
end
