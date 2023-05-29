require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relations' do
    it { should belong_to(:classroom).optional }
  end

  describe 'Model' do
    subject (:user) { build(:user) }

    it 'should be valid when all attributes are valid' do
      user.save
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'should be invalid when name is nil' do
      user.name = nil
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:name)
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'should be invalid when name is less than 3 characters' do
      user.name = 'ab'
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:name)
      expect(user.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'should be invalid when name is more than 255 characters' do
      user.name = 'a' * 256
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:name)
      expect(user.errors[:name]).to include('is too long (maximum is 255 characters)')
    end

    it 'should be invalid when cpf is nil' do
      user.cpf = nil
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:cpf)
    end

    it 'should be invalid when cpf is not 11 digits' do
      user.cpf = '123'
      user.save
      expect(user).to be_invalid
      expect(user.errors[:cpf]).to include('is the wrong length (should be 11 characters)')

      user.cpf = '123456789101111111'
      user.save
      expect(user).to be_invalid
      expect(user.errors[:cpf]).to include('is the wrong length (should be 11 characters)')
    end

    it 'should be invalid when cpf is not unique' do
      user.save
      expect(user).to be_valid

      user2 = build(:user, cpf: user.cpf)
      user2.save
      expect(user2).to be_invalid
      expect(user2.errors).to include(:cpf)
      expect(user2.errors[:cpf]).to include('has already been taken')
    end

    it 'should be invalid when cpf is not a number' do
      user.cpf = 'abcdefg123'
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:cpf)
      expect(user.errors[:cpf]).to include('is not a number')
    end

    it 'should be invalid when email is not unique' do
      user.save
      expect(user).to be_valid

      user2 = build(:user, email: user.email)
      user2.save
      expect(user2).to be_invalid
      expect(user2.errors).to include(:email)
      expect(user2.errors[:email]).to include('has already been taken')
    end

    it 'should be invalid when email is nil' do
      user.email = nil
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:email)
    end

    it 'should be invalid when password is nil' do
      user.password = nil
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:password)
    end

    it 'should be invalid when password is long enough' do
      user.password = 'abc@1'
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:password)
      expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
    end

    it 'should be invalid when password has no letters' do
      user.password = '12345678@'
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:password)
      expect(user.errors[:password]).to include('Password must have at least 1 letter')
    end

    it 'should be invalid when password has no numbers' do
      user.password = 'abcdefghi@'
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:password)
      expect(user.errors[:password]).to include('Password must have at least 1 number')
    end

    it 'should be invalid when password has no special characters' do
      user.password = 'abcdefghi1'
      user.save
      expect(user).to be_invalid
      expect(user.errors).to include(:password)
      expect(user.errors[:password]).to include('Password must have at least 1 special character')
    end
  end

  describe 'Validations' do
    subject (:user) { build(:user) }
    it { should validate_presence_of :name }
    it { should validate_presence_of :cpf }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(255) }
    it { should validate_length_of(:cpf).is_equal_to(11) }
    it { should validate_uniqueness_of(:cpf).case_insensitive }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should validate_numericality_of(:cpf) }
  end

  describe 'Scopes' do
    context 'when searching by cpf' do
      subject (:user) { build(:user) }
      it 'should return the correct user' do
        user.save
        expect(User.by_cpf(user.cpf)).to include(user)
      end

      it 'should return an empty user list when not found' do
        expect(User.by_cpf('00000000000')).to be_empty
      end

      it 'should return an empty array when CPF is an empty string' do
        expect(User.by_cpf('')).to be_empty
      end
    end

    context 'when searching by name' do
      subject (:user) { build(:user) }
      it 'should return the correct user' do
        user.save
        expect(User.by_name(user.name)).to include(user)
      end

      it 'should return an empty user list when not found' do
        expect(User.by_name('')).to be_empty
      end
    end

    context 'when searching with name contains' do
      subject (:user) { build(:user, name: 'Ana Carolina') }
      it 'should return the correct user' do
        user.save
        expect(User.name_contains('Car')).to include(user)
        expect(User.name_contains('Ana')).to include(user)
        expect(User.name_contains('car')).to include(user)
      end

      it 'should return an empty user list when not found' do
        expect(User.name_contains('')).to be_empty
      end
    end

    context 'when searching unconfirmed email' do
      subject (:user) { build(:user) }
      it 'should return the correct user' do
        user.save
        expect(User.unconfirmed_email).to include(user)
      end

      it 'should return an empty user list when not found' do
        expect(User.unconfirmed_email).to be_empty
      end
    end

    context 'when searching confirmed email' do
      subject (:user) { build(:user) }
      it 'should return the correct user confirmed' do
        user.confirmed_at = Time.now
        user.save
        expect(User.confirmed_email).to include(user)
      end

      it 'should return an empty user list when not found' do
        expect(User.confirmed_email).to be_empty
      end
    end
  end

  describe 'Callbacks' do
    describe 'check if last admin' do
      let!(:admin_user) { create(:user, role: :admin) }

      context 'when user is the last admin' do
        it 'does not allow deletion' do
          expect { admin_user.destroy }.not_to change(User, :count)
          expect(admin_user.errors[:base]).to include('Cannot delete the last admin user.')
        end
      end

      context 'when user is not the last admin' do
        let!(:another_admin_user) { create(:user, role: :admin) }

        it 'allows deletion' do
          expect { admin_user.destroy }.to change(User, :count).by(-1)
        end
      end
    end
  end
end
