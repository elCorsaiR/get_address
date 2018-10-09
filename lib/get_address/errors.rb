module GetAddress
  class GetAddressError < StandardError
    attr_reader :message
    attr_reader :code

    def initialize(message = nil, code = nil)
      @message = message
      @code = code
    end

    def to_s
      "#{code}: #{message}"
    end
  end

  class AuthenticationError < GetAddressError; end
  class ResourceNotFoundError < GetAddressError; end
end