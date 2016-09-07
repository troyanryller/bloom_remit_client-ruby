# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Credit
      class History < Requests::BaseRequest
        private

        def type
          Requests::GET
        end

        def path
          Requests.normalize_path(Credit::BaseModel::PATH, attributes.slice(:api_token), 'history')
        end
      end
    end
  end
end
