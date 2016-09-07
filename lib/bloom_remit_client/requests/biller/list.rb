# frozen_string_literal: true
module BloomRemitClient
  module Requests
    module Biller
      class List
        PATH = '/api/v2/billers'
        include Virtus.model

        def call
          RequestsSender.new(params).()
        end

        def params
          {
            type: Requests::GET,
            url: {
              host: ::BloomRemitClient.host,
              path: PATH
            }
          }
        end
      end
    end
  end
end
