require 'json'

module IsilonApi
  class Quotas

    def initialize(connection)
      @conn = connection
    end

    def raw_quotas
      @quotas ||= request_quotas.body
    end


    def request_quotas
      @conn.get('/platform/1/quota/quotas')
    end

    def parse
      #Assumes there are only enough quotas to fit on a single page of results
      JSON.parse(raw_quotas)['quotas'].map { |quota| Quota.new(quota) }
    end

    def list
      parse
    end
  end
end
