# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Sender
      class FindByMobile < Requests::BaseRequest
        attribute :mobile, String

        validates :mobile, presence: true

        private

        def type
          Requests::GET
        end

        def path
          Requests.normalize_path(Sender::BaseModel::PATH, attributes.slice(:api_token), 'find_by_mobile')
        end

        def query_params
          attributes.slice(:api_secret, :mobile)
        end
      end
    end
  end
end
