class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @servers = Server.all
  end
end
