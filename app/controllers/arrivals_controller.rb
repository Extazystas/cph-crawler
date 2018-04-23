class ArrivalsController < ApplicationController
  def index
    @arrivals = ArrivalCrawler.perform

    render json: @arrivals.to_json, status: :ok
  end
end
