class TrafficController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if request.headers['Content-Type'] == 'text/xml'
      p request.headers['content-length']
      # Don't know what this does
      request.body.rewind
      data     = request.body.read
      # get activity row for today
      activity = Activity.where({ :account_id => params[:id], :recurrence_at => Date.now.strftime('%Y%m%d').to_i }).first
      if activity.blank?
        account  = Account.find(params[:id])
        activity = Activity.create({ account_id: account.id, recurrence_at: Date.now.strftime('%Y%m%d').to_i, amount_today: 0, amount_total: Activity.where(account_id: params[:id]).sum(:amount_today), allowance: account.account_type.data_limit })
      end
      # Check daily amount
      new_amount = activity.amount_today + request.headers['content-length'].to_i
      if new_amount > activity.allowance
        # if within less than one hour
          # send notification to account owner
          # save hosts
          # save host datas
          # save services
        # else
          # Upgrade Required
          render status: 426
        # end
      else
        # Set new daily amount
        activity.amount_today = new_amount
        activity.amount_total = new_amount
        activity.save
        # save hosts
        # save host datas
        # save services
      end
      render status: 200
    else
      # Expectation Failed
      render status: 417
    end
  end
end
