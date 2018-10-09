RSpec.describe GetAddress::Utils do
  describe '.present?' do
    describe 'when nil' do
      it 'return false' do
        expect(GetAddress::Utils.present? nil).to be_falsey
      end
    end

    describe 'when empty string' do
      it 'return false' do
        expect(GetAddress::Utils.present? '').to be_falsey
      end
    end

    describe 'when not an empty string' do
      it 'return false' do
        expect(GetAddress::Utils.present? '1').to be_truthy
      end
    end
  end
end