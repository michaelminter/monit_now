class ServicesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reorder
    if params['column-1'].present? && !params['column-1'].empty?
      params['column-1'].each do |service|
        Service.find(service).update_attributes({ order_column: 1, order_row: params['column-1'].index(service) })
      end
    end
    if params['column-2'].present? && !params['column-2'].empty?
      params['column-2'].each do |service|
        Service.find(service).update_attributes({ order_column: 2, order_row: params['column-2'].index(service) })
      end
    end
    if params['column-3'].present? && !params['column-3'].empty?
      params['column-3'].each do |service|
        Service.find(service).update_attributes({ order_column: 3, order_row: params['column-3'].index(service) })
      end
    end
    render :nothing => true, status: 200
  end
end
