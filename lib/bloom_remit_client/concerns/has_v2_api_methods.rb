# frozen_string_literal: true
module BloomRemitClient
  module Concerns
    module HasV2ApiMethods
      def self.included(base)
        base.class_eval do
          # GET
          # /api/v2/exchange_rates/:pair
          # Parameters:
          #   api_secret:
          #     String, required
          #   api_token:
          #     String, required
          #   pair:
          #     String, optional
          def exchange_rates_v2(params = {})
            request_params = params.merge(access_params)
            request = Requests::V2::Rate::Show.new(request_params)
            request.call!
          end
        end
      end
    end
  end
end
