class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @portlets = { one: [], two: [], three: [] }
    @current_account.dashboard_portlets.order_by(order_column: :asc, order_row: :asc).each do |portlet|
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
