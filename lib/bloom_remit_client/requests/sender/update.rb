# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Sender
      class Update < Requests::BaseRequest
        attribute :sender_id, String
        attribute :sender, Sender::BaseModel

        validates :sender_id, :sender, presence: true

        def to_h
          attributes.merge(sender: sender.to_h)
        end

        private

        def type
          Requests::PUT
        end

        def path
          Requests.normalize_path(Sender::BaseModel::PATH, attributes.slice(:api_token), sender_id)
        end

        def body_params
          to_h.except(:api_token, :api_secret, :sender_id)
        end
      end
    end
  end
end
