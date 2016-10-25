module IsilonApi
  module Quotas

    def self.get_quotas

    end

    class QuotaResponse
      def initialize(response)
        @response = JSON.parser(response)
      end

      def hard_limit
        @res
      end
    end

  end
end