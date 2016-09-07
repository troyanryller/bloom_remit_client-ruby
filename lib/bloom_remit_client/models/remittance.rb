module BloomRemitClient
  class Remittance
    include Virtus.model
    attribute :id, String
    attribute :teller_id, String
    attribute :recipient_id, String
    attribute :sender_id, String
    attribute :vendor_external_id, String
    attribute :paid_in_orig_currency, Float
    attribute :receivable_in_dest_currency, Float
    attribute :flat_fee_in_orig_currency, Float
    attribute :forex_margin, Float
    attribute :payout_method, String
    attribute :tracking_sender, String
    attribute :tracking_number, String
    attribute :status_description, String
    attribute :account_name, String
    attribute :account_number, String
    attribute :callback_url, String
  end
end
