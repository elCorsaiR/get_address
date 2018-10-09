# GetAddress Ruby Library

A ruby wrapper for [getaddress.io](https://getaddress.io/) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'get_address'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install get_address

## Usage
```ruby
GetAddress.get_address postcode, house, options
```

**Arguments**

- `postcode` (string). The postcode you want to find.
- `house` (string, optional). House name/number.
- `options` (hash, optional). 
	- `sort` (boolean). Numerically sorts the addresses.

**Returns**

Returns a list of addresses for a postcode.

**Example**

```ruby
GetAddress.api_key = 'getaddress_api_key'

addresses = GetAddress.get_address 'XX2 00X'
addresses.each do |address|
  puts "Line 1: #{address.line1}"
  puts "Line 2: #{address.line2}"
  puts "Line 3: #{address.line3}"
  puts "Town/City: #{address.city}"
  puts "County: #{address.county}"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elCorsaiR/get_address.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).