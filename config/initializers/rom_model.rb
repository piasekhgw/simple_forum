module ROM
  module Model
    module Validator
      def initialize(attributes, root = attributes, parent = nil)
        @attributes = attributes
        @root = root
        @parent = parent
        @attr_names = @attributes.to_hash.keys
      end
    end
  end
end
