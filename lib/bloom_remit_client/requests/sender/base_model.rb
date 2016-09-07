module BloomRemitClient
  module Requests
    module Sender
      class BaseModel
        PATH = '/api/v1/partners/:api_token/senders'
        include Virtus.model
        include ActiveModel::Validations

        attribute :first_name, String
        attribute :last_name, String
        attribute :email, String
        attribute :mobile, String
        attribute :address, String
        attribute :city, String
        attribute :country, String
        attribute :postal_code,String
        # TODO: parse & validate date format.
        attribute :birthday, String
        # TODO:
        # attribute :identification[url]
        # attribute :proof_of_address[url]

        validates :first_name, :last_name, :email, :mobile, presence: true
        def call
          to_h
        end
      end
    end
  end
end
