# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Sender
      class FindByEmail < Requests::BaseRequest
        attribute :email, String

        validates :email, presence: true

        private

        def type
          Requests::GET
        end

        def path
          Requests.normalize_path(Sender::BaseModel::PATH, attributes.slice(:api_token), 'find_by_email')
        end

        def query_params
          attributes.slice(:api_secret, :email)
        end
      end
    end
  end
end
