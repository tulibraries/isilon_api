module IsilonApi
    class Quota

      attr_reader :raw

      def
        initialize(args)
        @raw = args[:quota]

      end

      def id
        raw['id']
      end

      def path
        raw['path']
      end

      def name
        path.split('/').last
      end

      def hard_limit
        raw['thresholds']['hard']
      end

      def soft_limit
        raw['thresholds']['advisory']
      end

      def usage
        raw['usage']['logical']
      end

      def percent_used
        # Show percent used to 2 decimal places
        ((usage * 100) / hard_limit) / 100.to_f
      end

      def free_space
        hard_limit - usage
      end

    end
end
