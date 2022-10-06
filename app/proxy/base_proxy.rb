# frozen_string_literal: true

require 'httparty'

class BaseProxy
  def proxy_api(url, api_method, payload)
    logger.debug 'Following is the Request payload for Proxy Server...'
    logger.debug payload

    begin
      response = if api_method == 'POST'
                   HTTParty.post(
                     url, {
                       body: payload,
                       headers: {
                         'Content-Type' => 'application/x-www-form-urlencoded',
                         'Accept' => 'application/json'
                       }
                     }
                   )
                 else
                   HTTParty.get(
                     url, {
                       body: payload.to_json,
                       headers: {
                         'Content-Type' => 'application/json',
                         'Accept' => 'application/json'
                       }
                     }
                   )
                 end

      logger.info "DynamicsProxy Response code: #{response.code}"
      logger.info response.to_s
      response
    rescue StandardError => e
      puts e
      raise StandardError, "Proxy is Down...#{e}"
    end
  end

  def logger
    @logger = Rails.logger
  end
end
