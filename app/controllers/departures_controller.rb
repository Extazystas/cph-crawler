class DeparturesController < ApplicationController
  def index
    @departures = DepartureCrawler.perform

    render json: @departures.to_json, status: :ok
  end
end
