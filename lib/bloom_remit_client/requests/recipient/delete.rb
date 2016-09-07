# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Recipient
      class Delete < Requests::BaseRequest
        attribute :sender_id, String
        attribute :recipient_id, String

        validates :sender_id, :recipient_id, presence: true

        private

        def type
          Requests::DELETE
        end

        def path
          Requests.normalize_path(Recipient::BaseModel::PATH, attributes.slice(:api_token, :sender_id), recipient_id)
        end
      end
    end
  end
end
