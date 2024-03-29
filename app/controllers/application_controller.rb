class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_action :current_account

  def current_account
    @current_account ||= current_user.accounts.first rescue ''
  end

  def xml_logger
    @@xml_logger ||= Logger.new("#{Rails.root}/log/xml.log")
  end

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end
end
