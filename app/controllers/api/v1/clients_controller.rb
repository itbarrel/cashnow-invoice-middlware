# frozen_string_literal: true

class Api::V1::ClientsController < Api::V1::ApiController
  def index
    service = ClientService.new
    query = params[:query] || {}
    query[:username_eq] = params[:username]
    render json: service.all(query)
  end
end
