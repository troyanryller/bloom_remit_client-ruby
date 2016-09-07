require 'virtus'
require 'httparty'
require 'active_model'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/try'
require 'bloom_remit_client/coercers/indifferent_hash'
require 'bloom_remit_client/concerns/has_base_authentification'
require 'bloom_remit_client/host_attribute'
require "bloom_remit_client/version"
require "bloom_remit_client/client"
require "bloom_remit_client/models/biller"
require "bloom_remit_client/models/user"
require "bloom_remit_client/models/payment"
require "bloom_remit_client/requests"
require "bloom_remit_client/requests/url_builder"
require "bloom_remit_client/requests/requests_sender"
require "bloom_remit_client/requests/base_request"
require "bloom_remit_client/requests/biller/list"
# Payments:
require "bloom_remit_client/requests/payment/base_model"
require "bloom_remit_client/requests/payment/create"
# Credits:
require "bloom_remit_client/requests/credit/base_model"
require "bloom_remit_client/requests/credit/list"
require "bloom_remit_client/requests/credit/history"
# Agents:
require "bloom_remit_client/requests/agent/base_model"
require "bloom_remit_client/requests/agent/list"
require "bloom_remit_client/requests/agent/show"
require "bloom_remit_client/requests/agent/create"
require "bloom_remit_client/requests/agent/update"
require "bloom_remit_client/requests/agent/delete"
# Senders:
require "bloom_remit_client/requests/sender/base_model"
require "bloom_remit_client/requests/sender/list"
require "bloom_remit_client/requests/sender/show"
require "bloom_remit_client/requests/sender/create"
require "bloom_remit_client/requests/sender/update"
require "bloom_remit_client/requests/sender/delete"
require "bloom_remit_client/requests/sender/find_by_mobile"
require "bloom_remit_client/requests/sender/find_by_email"
# Recipients:
require "bloom_remit_client/requests/recipient/base_model"
require "bloom_remit_client/requests/recipient/list"
require "bloom_remit_client/requests/recipient/show"
require "bloom_remit_client/requests/recipient/create"
require "bloom_remit_client/requests/recipient/update"
require "bloom_remit_client/requests/recipient/delete"
# Remittances:
require "bloom_remit_client/requests/remittance/base_model"
require "bloom_remit_client/requests/remittance/list"
require "bloom_remit_client/requests/remittance/show"
require "bloom_remit_client/requests/remittance/create"
require "bloom_remit_client/requests/remittance/delete"
require "bloom_remit_client/requests/remittance/calculate"
require "bloom_remit_client/responses/base_response"
require "bloom_remit_client/responses/billers_response"
require "bloom_remit_client/responses/create_sender_response"
require "bloom_remit_client/responses/create_payment_response"

module BloomRemitClient
  PRODUCTION = 'api.bloom.solutions'
  STAGING = 'bloomremit-staging.herokuapp.com'

  class << self
    def new(*args)
      client = Client.new(*args)
      raise ArgumentError, client.errors.full_messages if client.invalid?
      client
    end

    def sandbox=(value)
      @sandbox = value
    end

    def sandbox
      @sandbox
    end

    def host=(value)
      @host = value
    end

    def host
      return @host if @host
      sandbox ? STAGING : PRODUCTION
    end
  end
end
