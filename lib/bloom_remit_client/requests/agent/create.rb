# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Agent
      class Create < Requests::BaseRequest
        attribute :agent, Agent::BaseModel
        validates :agent, presence: true

        def to_h
          attributes.merge(agent: agent.to_h)
        end

        private

        def type
          Requests::POST
        end

        def path
          Requests.normalize_path(Agent::BaseModel::PATH, attributes.slice(:api_token))
        end

        def body_params
          to_h.except(:api_token, :api_secret)
        end
      end
    end
  end
end
