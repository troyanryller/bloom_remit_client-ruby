# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Remittance
      class Create < Requests::BaseRequest
        attribute :agent_id, String
        attribute :recipient_id, String
        attribute :sender_id, String
        attribute :remittance, Remittance::BaseModel

        validates :agent_id, :recipient_id, :sender_id, :remittance, presence: true

        def to_h
          attributes.merge(remittance: remittance.to_h)
        end

        private

        def type
          Requests::POST
        end

        def path
          Requests.normalize_path(Remittance::BaseModel::PATH, attributes.slice(:api_token, :sender_id))
        end

        def body_params
          to_h.except(:api_token, :api_secret, :sender_id)
        end
      end
    end
  end
end
