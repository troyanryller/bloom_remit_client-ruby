# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module V2
      module Rate
        class Show < Requests::Base

          include Concerns::HasBaseAuthentification

          PATH = '/api/v2/exchange_rates'

          attribute :pair, String

          private

          def type
            Requests::GET
          end

          def path
            "#{PATH}/#{pair}"
          end

          def query_params
            attributes.slice(:api_secret, :api_token)
          end
        end
      end
    end
  end
end
