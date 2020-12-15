require 'rails_helper'

RSpec.describe InviteCode, type: :model do
  describe 'creation & invalidation' do
    let(:invite_code) { InviteCode.create }

    it 'automatically creates a random invite code' do
      expect(invite_code.code).to be_truthy
    end

    it 'does not create a code if one is already present' do 
      with_code = InviteCode.new(code: 'foobar')
      with_code.save
      expect(with_code.code).to eql('foobar')
    end

    it 'sets the current datetime on invalidation' do
      invite_code.invalidate!
      expect(invite_code.used_at).to be_within(1.minute).of Time.now
    end
  end


  describe 'unused scope' do
    it 'does not return invalidated codes' do
      FactoryBot.create_list(:invite_code, 5)
      FactoryBot.create_list(:invite_code, 5, :used)

      expect(InviteCode.unused.count).to eql(5)
    end
  end
end
