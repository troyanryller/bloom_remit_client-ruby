# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Payment
      class Create < Requests::BaseRequest
        attribute :sender_id, String
        attribute :agent_id, String
        attribute :payment, Payment::BaseModel

        validates :sender_id, :agent_id, :payment, presence: true

        def to_h
          attributes.merge(payment: payment.to_h)
        end

        private

        def type
          Requests::POST
        end

        def path
          Payment::BaseModel::PATH
        end

        def body_params
          to_h
        end
      end
    end
  end
end
