# frozen_string_literal: true

class Api::V1::ApiController < ActionController::API
  include ActionController::RequestForgeryProtection
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protect_from_forgery with: :null_session
  respond_to :json

  before_action :authenticate_client

  def authenticate_client
    if request.headers['Authorization'].nil?
      head :unauthorized
      return
    end

    @token = request.headers['Authorization'].split(' ').last
    @current_client = Client.find_by_api_token(@token)

    head :unauthorized if @current_client.nil?
  end
end
