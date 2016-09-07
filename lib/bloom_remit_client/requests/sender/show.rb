# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Sender
      class Show < Requests::BaseRequest
        attribute :sender_id, String

        validates :sender_id, presence: true

        private

        def type
          Requests::GET
        end

        def path
          Requests.normalize_path(Sender::BaseModel::PATH, attributes.slice(:api_token), sender_id)
        end
      end
    end
  end
end
