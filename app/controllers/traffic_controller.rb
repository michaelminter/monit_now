class TrafficController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if request.headers["Content-Type"] == 'text/xml'
      #content_type 'application/xml'
      request.body.rewind
      data = request.body.read
      activity = Activity.find(params[:id]).where(:date => Date.now.strftime('%m'))
      p request.headers['content-length']
      render status: 200
    else
      render status: 417
    end
  end
end
