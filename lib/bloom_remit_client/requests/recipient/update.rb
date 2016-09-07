# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Recipient
      class Update < Requests::BaseRequest
        attribute :sender_id, String
        attribute :recipient_id, String
        attribute :recipient, Recipient::BaseModel

        validates :sender_id, :recipient_id, presence: true

        def to_h
          attributes.merge(recipient: recipient.to_h)
        end

        private

        def type
          Requests::PUT
        end

        def path
          Requests.normalize_path(Recipient::BaseModel::PATH, attributes.slice(:api_token, :sender_id), recipient_id)
        end

        def body_params
          to_h.except(:api_token, :api_secret, :sender_id)
        end
      end
    end
  end
end
