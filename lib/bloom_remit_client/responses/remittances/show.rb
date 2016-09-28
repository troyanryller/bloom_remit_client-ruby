module BloomRemitClient
  module Responses
    module Remittances
      class Show < Base
        attribute :remittance, Object, lazy: true, default: :default_remittance

        private

        def default_remittance
          Remittance.new(body[:remittance])
        end
      end
    end
  end
end
