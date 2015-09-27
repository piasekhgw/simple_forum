require 'rails_helper'

describe UserRegistrationForm do
  subject { described_class.build(user_registration_params) }

  describe '#save' do
    before { subject.save }

    context 'invalid input params' do
      let(:user_registration_params) {
        { email: 'foo' }
      }

      it 'sets errors on object' do
        expect(subject.errors).to_not be_empty
      end
    end

    context 'valid input params' do
      let(:user_registration_params) {
        { email: 'foo@bar.pl', name: 'foo', password: 'foo_bar', password_confirmation: 'foo_bar' }
      }

      it "doesn't set errors on object" do
        expect(subject.errors).to be_empty
      end

      it "persists data" do
        tuple = @rom.relation(:users).where(email: 'foo@bar.pl').first
        expect(tuple[:name]).to eq('foo')
        expect(BCrypt::Password.new(tuple[:password_digest])).to eq('foo_bar')
      end
    end
  end
end
