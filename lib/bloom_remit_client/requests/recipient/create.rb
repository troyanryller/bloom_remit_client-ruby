# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Recipient
      class Create < Requests::BaseRequest
        attribute :sender_id, String
        attribute :recipient, Recipient::BaseModel

        validates :sender_id, :recipient, presence: true

        def to_h
          attributes.merge(recipient: recipient.to_h)
        end

        private

        def type
          Requests::POST
        end

        def path
          Requests.normalize_path(Recipient::BaseModel::PATH, attributes.slice(:api_token, :sender_id))
        end

        def body_params
          to_h.except(:api_token, :api_secret, :sender_id)
        end
      end
    end
  end
end
