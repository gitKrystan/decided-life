module CoreExtensions
  module Symbol
    module ToFoo
      def to_c
        to_s.camelize.constantize
      end
    end
  end
end
