# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Remittance
      class Delete < Requests::BaseRequest
        attribute :sender_id, String
        attribute :remittance_id, String

        validates :sender_id, :remittance_id, presence: true

        private

        def type
          Requests::DELETE
        end

        def path
          Requests.normalize_path(Remittance::BaseModel::PATH, attributes.slice(:api_token, :sender_id), remittance_id)
        end
      end
    end
  end
end
