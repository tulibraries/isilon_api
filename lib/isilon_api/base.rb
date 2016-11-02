require 'faraday'

class IsilonApi::Base

  def initialize
    @conn ||= connection
  end

  def get_quotas
    IsilonApi::Quotas.new(connection).list
  end

  def connection
    conn = Faraday.new(:url => base_uri) do |faraday|
      faraday.request  :retry
      #faraday.response :logger  # log requests to STDOUT
      faraday.adapter  :net_http
    end
    conn.basic_auth(config.user, config.password)
    conn
  end

  def base_uri
    "https://#{config.host}:#{config.port}"
  end

  def config
    IsilonApi.configuration
  end
end
