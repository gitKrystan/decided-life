module CoreExtensions
  module String
    module Numeric
      def numeric?
        true if Float(self)
      rescue
        false
      end
    end
  end
end
