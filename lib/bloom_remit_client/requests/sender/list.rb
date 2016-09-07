# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Sender
      class List < Requests::BaseRequest
        private

        def type
          Requests::GET
        end

        def path
          Requests.normalize_path(Sender::BaseModel::PATH, attributes.slice(:api_token))
        end
      end
    end
  end
end
