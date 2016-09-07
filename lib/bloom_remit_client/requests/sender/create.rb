# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Sender
      class Create < Requests::BaseRequest
        attribute :agent_id, String
        attribute :sender, Sender::BaseModel

        validates :agent_id, :sender, presence: true

        def to_h
          attributes.merge(sender: sender.to_h)
        end

        private

        def type
          Requests::POST
        end

        def path
          Requests.normalize_path(Sender::BaseModel::PATH, attributes.slice(:api_token))
        end

        def body_params
          to_h.except(:api_token, :api_secret)
        end
      end
    end
  end
end
