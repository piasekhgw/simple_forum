require 'rom/rails/model/form'

module OmniAuth
  module Identity
    module Models
      module Rom
        def self.included(base)
          base.class_eval do
            include OmniAuth::Identity::Model

            alias create save

            def persisted?
              validator.valid?
            end

            def self.locate(search_hash)
              where(search_hash).first
            end

            private

            def validator
              @validator ||= self.class.validator.new(attributes)
            end
          end
        end
      end
    end
  end
end
