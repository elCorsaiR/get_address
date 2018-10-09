require 'virtus'

module GetAddress
  class Address
    include Virtus.model

    attribute :line1, String
    attribute :line2, String
    attribute :line3, String
    attribute :city, String
    attribute :county, String
    attribute :latitude,  Float
    attribute :longitude, Float
  end
end