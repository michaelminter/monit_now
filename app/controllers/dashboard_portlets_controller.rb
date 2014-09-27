class DashboardPortletsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    portlet = Portlet.find(params[:id])
    begin
      portlet.dashboard_portlets.create({
          :dashboard_id => '',
          :server_id => portlet.server_id,
          :account_id => portlet.account_id,
          :order_column => portlet.order_column,
          :order_row => portlet.order_row,
          :name => portlet.name,
          :type => portlet[:type]
      })
      render :nothing => true, status: 200
    rescue Exception => e
      Rollbar.report_exception(e)
      render :nothing => true, status: 400
    end
  end

  def delete
    DashboardPortlet.where({ :portlet_id => params[:id] }).delete
    render :nothing => true, status: 200
  end
end
