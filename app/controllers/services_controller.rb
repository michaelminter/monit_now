class ServicesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reorder
    p params
    if params['column-3'].present? && !params['column-3'].empty?
      params['column-3'].each do |service|
        #Service.find(service).update_attributes({ column_order: 3, row_order: 0 })
      end
    end
    render :nothing => true, status: 200
  end
end
