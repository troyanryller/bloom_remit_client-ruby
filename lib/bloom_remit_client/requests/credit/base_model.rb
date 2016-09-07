module BloomRemitClient
  module Requests
    module Credit
      class BaseModel
        PATH = '/api/v1/partners/:api_token/credits'
        include Virtus.model
        include ActiveModel::Validations

        def call
          to_h
        end
      end
    end
  end
end
