RSpec.describe GetAddress do
  it 'has a version number' do
    expect(GetAddress::VERSION).not_to be nil
  end

  describe '.get_address' do
    it 'returns a list of addresses for a postcode' do
      addresses = GetAddress.get_address 'XX2 00X'
      expect(addresses).to_not be_empty
    end

    it 'returns an empty list when there are no addresses' do
      addresses = GetAddress.get_address 'XX4 04X'
      expect(addresses).to be_empty
    end

    it 'raises an exception when postcode does not exist' do
      expect {
        GetAddress.get_address 'XX4 00X'
      }.to raise_error(GetAddress::GetAddressError)
    end

    it 'raises an exception when account is expired' do
      expect {
        GetAddress.get_address 'XX2 00X'
      }.to raise_error(GetAddress::GetAddressError)
    end

    it 'raises an exception if there is no key' do
      GetAddress.api_key = nil
      expect {
        GetAddress.get_address 'XX2 00X'
      }.to raise_error(GetAddress::AuthenticationError)
    end

    it 'raises an exception if key is not valid' do
      GetAddress.api_key = 'wrong'
      expect {
        GetAddress.get_address 'XX2 00X'
      }.to raise_error(GetAddress::AuthenticationError)
    end

    describe 'when house param passed' do
      describe 'when house is not present' do
        it 'returns an empty list' do
          addresses = GetAddress.get_address 'XX2 00X', '1'
          expect(addresses).to be_empty
        end
      end

      describe 'when house is present' do
        it 'returns a list of addresses for a postcode' do
          addresses = GetAddress.get_address 'XX2 00X', '658'
          expect(addresses).to_not be_empty
        end
      end
    end

    describe 'when options is passed' do
      it 'returns a list of addresses for a postcode' do
        addresses = GetAddress.get_address 'XX2 00X', '', sort: true
        expect(addresses).to_not be_empty
      end

    end
  end
end
