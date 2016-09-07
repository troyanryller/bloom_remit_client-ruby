# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Remittance
      class BaseModel
        PATH = '/api/v1/partners/:api_token/senders/:sender_id/remittances'

        include Virtus.model
        include ActiveModel::Validations

        attribute :orig_currency, String
        attribute :paid_in_orig_currency, Float
        attribute :flat_fee_in_orig_currency, Float
        attribute :forex_margin, Float
        attribute :dest_currency, String
        attribute :receivable_in_dest_currency, Float
        attribute :payout_method, String
        attribute :account_name, String
        attribute :account_number, String
        attribute :callback_url, String

        # TODO: move available currencies to some constant.
        validates :orig_currency, presence: true,
                                  inclusion: %w(PHP USD KRW AUD CAD JPY NZD SGD HKD CNY EUR
                                                VND SAR TWD QAR KWD AED GBP MYR INR IDR BTC)
        validates :dest_currency, presence: true,
                                  inclusion: %w(PHP USD KRW AUD CAD JPY NZD SGD HKD CNY EUR
                                                VND SAR TWD QAR KWD AED GBP MYR INR IDR BTC)
        # TODO: move available payout methods to some constant.
        validates :payout_method, presence: true,
                                  inclusion: %w(CLH MLH TAM BAYAD MGRA AUB BOC BDO BDOI BPI
                                                BPIFS CBC CBS CTB CSI DBP EWB EQB HSB HBP LBP
                                                LBC LBCP MSB MPI MBTC MET PNB ALL ASB PSB PVB
                                                RCB RSB SEC SBS SCB SBA TYB UBP UCPB USB BSB ACB)
        def call
          to_h
        end
      end
    end
  end
end
