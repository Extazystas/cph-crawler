module Api::V1
  class DeparturesController < ApplicationController
    def index
      @departures = DepartureCrawler.perform

      render json: @departures.to_json, status: :ok
    rescue SocketError => e
      render json: { errors: 'Error: No Internet connection.' }, status: 422
    end
  end
end
