require 'httparty'

class BaseProxy
    def proxy_api(url, api_method, payload)
      logger.debug "Following is the Request payload for Proxy Server..."
      logger.debug payload

      begin
        if api_method == "POST"
          response = HTTParty.post(url, {
            body: payload,
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded',
              'Accept' => 'application/json',
            }
          })
        else
          response = HTTParty.get(url, {
            body: payload.to_json,
            headers: {
              'Content-Type' => 'application/json',
              'Accept' => 'application/json',
            }
          })
        end

        logger.info "DynamicsProxy Response code: #{response.code}"
        logger.info "#{response}"
        return response
      rescue => err
        puts err
        raise StandardError.new("Proxy is Down...#{err}") 
      end
    end

    def logger
      @logger = Rails.logger
    end
end