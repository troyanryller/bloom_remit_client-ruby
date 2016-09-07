module BloomRemitClient
  module Requests
    module Agent
      class BaseModel
        PATH = '/api/v1/partners/:api_token/agents'

        include Virtus.model
        include ActiveModel::Validations

        attribute :name, String
        validates :name, presence: true

        def call
          to_h
        end
      end
    end
  end
end
