RSpec.describe GetAddress::Address do
  let(:address) { GetAddress::Address.new }
  subject{ address }

  it { is_expected.to respond_to :line1, :line2, :line3, :city, :county, :latitude, :longitude }
end