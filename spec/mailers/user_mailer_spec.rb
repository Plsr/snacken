require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "activation_needed_email" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.activation_needed_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to dishbot")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@dishbot.app"])
    end
  end
end
