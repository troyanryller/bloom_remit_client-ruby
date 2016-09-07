# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Remittance
      class Calculate < Requests::BaseRequest
        attribute :origin_amount, Float
        attribute :destination_amount, Float
        attribute :origin_currency, String
        attribute :destination_currency, String
        attribute :payout_method, String

        # TODO: move available payout methods to some constant.
        validates :payout_method, presence: true,
                                  inclusion: %w(CLH MLH TAM BAYAD MGRA AUB BOC BDO BDOI BPI
                                                BPIFS CBC CBS CTB CSI DBP EWB EQB HSB HBP LBP
                                                LBC LBCP MSB MPI MBTC MET PNB ALL ASB PSB PVB
                                                RCB RSB SEC SBS SCB SBA TYB UBP UCPB USB BSB ACB)

        def to_h
          attributes.merge(remittance: remittance.to_h)
        end

        private

        def type
          Requests::POST
        end

        def path
          Requests.normalize_path('/api/v1/partners/:api_token/remittances/calculate', attributes.slice(:api_token))
        end

        def body_params
          to_h.except(:api_token, :api_secret)
        end
      end
    end
  end
end
