class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_account
    current_user.accounts.first
  end

  def xml_logger
    @@xml_logger ||= Logger.new("#{Rails.root}/log/xml.log")
  end
end
