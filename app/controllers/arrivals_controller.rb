class ArrivalsController < ApplicationController
  def index
    @arrivals = ArrivalCrawler.perform

    render json: @arrivals.to_json, status: :ok
  rescue SocketError => e
    render json: { errors: 'Error: No Internet connection.' }, status: 422
  end
end
