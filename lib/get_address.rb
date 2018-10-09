require 'uri'
require 'cgi'
require 'rest-client'
require 'json'

require 'get_address/version'
require 'get_address/errors'
require 'get_address/utils'
require 'get_address/address'

module GetAddress
  @endpoint = 'https://api.getAddress.io'

  class << self
    attr_accessor :api_key, :endpoint
  end


  def self.get_address(postcode, house = '', options = {})
    path = house == '' ? "find/#{postcode}" : "find/#{postcode}/#{house}"
    query = options[:sort].nil? ? {} : { sort: options[:sort] }
    GetAddress.request :get, path, query
  rescue ResourceNotFoundError => error
    []
  end

  private

  def self.request(method, path, params = {})
    unless @api_key
      raise AuthenticationError.new('No API Key provided')
    end

    url = URI.parse(resource_url(path))

    params.merge!({ 'api-key' => @api_key, 'format' => true })
    url.query = Utils.escape_params(params)

    request_options = {
        method: method,
        url: url.to_s
    }

    begin
      response = RestClient::Request.execute(request_options)
    rescue RestClient::ExceptionWithResponse => error
      if (code = error.http_code) && (body = error.http_body)
        handle_rest_error(code, body)
      else
        handle_error(error)
      end
    rescue RestClient::Exception, Errno::ECONNREFUSED => error
      handle_error(error)
    end

    process response.body
  end

  def self.resource_url(path = '')
    URI.escape "#{@endpoint}/#{path}"
  end

  def self.handle_rest_error(http_code, http_body)
    error = parse http_body
    message = error['Message']

    case http_code
    when 401
      raise AuthenticationError.new message, http_code
    when 404
      raise ResourceNotFoundError.new message, http_code
    else
      raise GetAddressError.new message, http_code
    end
  end

  def self.process(response)
    response_hash = parse response

    latitude = response_hash['latitude']
    longitude = response_hash['longitude']
    response_hash['addresses'].map do |addr_hash|
      Address.new line1: addr_hash[0], line2: addr_hash[1], line3: addr_hash[2], city: addr_hash[3],
                  county: addr_hash[4], latitude: latitude, longitude: longitude
    end
  end

  def self.parse(response)
    JSON.parse(response)
  rescue JSON::ParserError => e
    raise handle_error(e)
  end

  def self.handle_error(error)
    raise GetAddressError.new("An unexpected error occurred: #{error.message})")
  end

end
