class HomeController < ApplicationController
  def index
    @servers = Server.all
    if user_signed_in?
      redirect_to dashboard_path
    else

    end
  end
end
