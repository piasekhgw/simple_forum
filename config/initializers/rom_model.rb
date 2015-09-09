module ROM
  module Model
    module Validator
      private

      def method_missing(name, *args, &block)
        attributes[name] || super
      end
    end
  end
end
