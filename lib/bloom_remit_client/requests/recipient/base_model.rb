module BloomRemitClient
  module Requests
    module Recipient
      class BaseModel
        PATH = '/api/v1/partners/:api_token/senders/:sender_id/recipients'

        include Virtus.model
        include ActiveModel::Validations

        attribute :first_name, String
        attribute :last_name, String
        attribute :email, String
        attribute :mobile, String
        attribute :address, String
        attribute :city, String
        attribute :state, String
        attribute :country, String
        attribute :postal_code,String

        validates :first_name, :last_name, :mobile, presence: true
        def call
          to_h
        end
      end
    end
  end
end
