# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Remittance
      class List < Requests::BaseRequest
        attribute :sender_id, String

        validates :sender_id, presence: true

        private

        def type
          Requests::GET
        end

        def path
          Requests.normalize_path(Remittance::BaseModel::PATH, attributes.slice(:api_token, :sender_id))
        end
      end
    end
  end
end
