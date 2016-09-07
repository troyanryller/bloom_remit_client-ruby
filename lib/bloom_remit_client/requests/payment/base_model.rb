# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Payment
      class BaseModel
        PATH = '/api/v2/payments'

        include Virtus.model
        include ActiveModel::Validations

        # attribute :sender_id, String
        attribute :external_id, String
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

        validates :external_id, presence: true
        # TODO: move available currencies to some constant.
        validates :orig_currency, presence: true,
                                  inclusion: %w(PHP USD KRW AUD CAD JPY NZD SGD HKD CNY EUR
                                                VND SAR TWD QAR KWD AED GBP MYR INR IDR BTC)
        validates :dest_currency, presence: true,
                                  inclusion: %w(PHP USD KRW AUD CAD JPY NZD SGD HKD CNY EUR
                                                VND SAR TWD QAR KWD AED GBP MYR INR IDR BTC)
        # TODO: move available payout methods to some constant.
        validates :payout_method, presence: true,
                                  inclusion: %w(BATELEC1 CDO_WATER PRIMEWATER DIGITEL SUNCELLULAR
                                                G-NET BAYANTEL PRC PLDT SMART MANILAWATER MAYNILAD
                                                GLOBELINES GHPHONE CABLELINK OPTIMUM_BANK VECO
                                                STA_LUCIA_REALTY SUMISHO SUBIC_ENERZONE NORKIS CIGNAL
                                                UNISTAR SKYCABLE PILIPINO_CABLE HM_CATV BRIGHTMOON_CABLE
                                                JMY_ADVANTAGE CAVITE_CABLE SUBURBAN_CABLE ISLA_CABLE
                                                TARLAC_CABLE SORSOGON_WATER BENECO ILECO1 PAL GOLDEN_HAVEN
                                                PELCO1 COTABATO_LIGHT AEON_CREDIT PESOPAY PRESCO MAYBRIDGE
                                                METRO_FASTBET SKYJET FIRST_PEAK PLUS_CABLE NORTHSTAR_CABLE
                                                VERDANT_CABLE LEISURE_WORLD RMG CARISSA GLOBALLAND
                                                CHINATRUST MCWD STA_MARIA_WATER MFI_LENDING ICONNEX
                                                GOODHANDS_WATER HAPPYWELL TARELCO2 AXA_PHIL CEBUPACIFIC
                                                NEECO2_AREA1 COMCLARK CENTRAL_LUZON_CABLE PRIMECAST_CABLE
                                                CANORECO INEC LAGUNAWATER AIRASIA BPI_CREDITCARD
                                                ANGELES_ELECTRIC BP_WATERWORKS HITECH_CABLE ROYALCABLE
                                                HONEYCOMB FLECO POEA SANCLEMENTE_CABLE GOLDEN_EAGLE_CABLE
                                                CALUMPIT_WATER COCOLIFE MABALACAT_WATER PENELCO VIACOM
                                                PARAMOUNT GLOBAL_DOMINION MYCLOUD INSULAR_SAVERS ASIALINK
                                                FINASWIDE SOUTH_ASIALINK CABLE_TELEVISION CEBECO2
                                                PAYEXPRESS NSOHELPLINE.COM PLANET_CABLE PROMO_ECPROTECT
                                                PHILSMILE ANGELES_CABLE PELCO2 AUB_CREDITCARDS DAVAOLIGHT
                                                HOME_LIPA_CABLE TABACO_WATER MET_CABLE DRAGONPAY
                                                ABS_MOBILE HOME_CREDIT GATE BATELEC2 CONVERGE_ICT
                                                RS_PROPERTY PELCO3 NEECO2_AREA2 SITELCO)

        def call
          to_h
        end
      end
    end
  end
end
