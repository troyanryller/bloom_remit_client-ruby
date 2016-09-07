# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Agent
      class Update < Requests::BaseRequest
        attribute :agent_id, String
        attribute :agent, Agent::BaseModel

        validates :agent_id, :agent, presence: true

        def to_h
          attributes.merge(agent: agent.to_h)
        end

        private

        def type
          Requests::PUT
        end

        def path
          Requests.normalize_path(Agent::BaseModel::PATH, attributes.slice(:api_token), agent_id)
        end

        def body_params
          to_h.except(:api_token, :api_secret)
        end
      end
    end
  end
end
