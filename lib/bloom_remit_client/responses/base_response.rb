module BloomRemitClient
  class BaseResponse

    include Virtus.model
    attribute :raw_response, Object
    attribute(:body, Coercers::IndifferentHash, {
      lazy: true,
      default: :default_body,
    })
    attribute :success, Boolean, lazy: true, default: :default_success

    private

    def default_success
      raw_response.success?
    end

    def default_body
      json = JSON.parse(raw_response.body)

      if json.is_a?(Array)
        json.map(&:with_indifferent_access)
      else
        json.with_indifferent_access
      end
    end

  end
end
