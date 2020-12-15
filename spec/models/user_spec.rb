require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is not valid without an invite code' do
    user = User.new(email: 'test@example.com', password: 'Test1234!', password_confirmation: 'Test1234!')
    expect(user.valid?).to be(false)
  end

  it 'is valid with an valid invite code' do
    invite_code = FactoryBot.create(:invite_code)
    user = User.new(email: 'test@example.com', password: 'Test1234!', password_confirmation: 'Test1234!', invite_code: invite_code.code)
    expect(user.valid?).to be(true)
  end

  it 'invalidates the invite code after creation' do
    invite_code = FactoryBot.create(:invite_code)
    user = User.create(email: 'test@example.com', password: 'Test1234!', password_confirmation: 'Test1234!', invite_code: invite_code.code)

    invite_code.reload
    expect(invite_code.used?).to be(true)
  end
end
