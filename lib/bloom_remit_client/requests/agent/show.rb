# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Agent
      class Show < Requests::BaseRequest
        attribute :agent_id, String
        validates :agent_id, presence: true

        private

        def type
          Requests::GET
        end

        def path
          Requests.normalize_path(Agent::BaseModel::PATH, attributes.slice(:api_token), agent_id)
        end
      end
    end
  end
end
