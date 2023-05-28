# require 'rails_helper'

# RSpec.describe User, type: :model do
#   describe 'Model' do
#     subject (:user) { build(:user) }

#     it 'should be valid when all attributes are valid' do
#       user.save
#       expect(user).to be_valid
#       expect(user.errors).to be_empty
#     end

#     it 'should be invalid when name is nil' do
#       user.name = nil
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:name)
#       expect(user.errors[:name]).to include("can't be blank")
#     end

#     it 'should be invalid when name is less than 3 characters' do
#       user.name = 'ab'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:name)
#       expect(user.errors[:name]).to include('is too short (minimum is 3 characters)')
#     end

#     it 'should be invalid when name is more than 255 characters' do
#       user.name = 'a' * 256
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:name)
#       expect(user.errors[:name]).to include('is too long (maximum is 255 characters)')
#     end

#     it 'should be invalid when cpf is nil' do
#       user.cpf = nil
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:cpf)
#     end

#     it 'should be invalid when cpf is not 11 digits' do
#       user.cpf = '123'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors[:cpf]).to include('is the wrong length (should be 11 characters)')

#       user.cpf = '123456789101111111'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors[:cpf]).to include('is the wrong length (should be 11 characters)')
#     end

#     it 'should be invalid when cpf is not unique' do
#       user.save
#       expect(user).to be_valid

#       user2 = build(:user, cpf: user.cpf)
#       user2.save
#       expect(user2).to be_invalid
#       expect(user2.errors).to include(:cpf)
#       expect(user2.errors[:cpf]).to include('has already been taken')
#     end

#     it 'should be invalid when cpf is not a number' do
#       user.cpf = 'abcdefg123'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:cpf)
#       expect(user.errors[:cpf]).to include('is not a number')
#     end

#     it 'should be invalid when email is not unique' do
#       user.save
#       expect(user).to be_valid

#       user2 = build(:user, email: user.email)
#       user2.save
#       expect(user2).to be_invalid
#       expect(user2.errors).to include(:email)
#       expect(user2.errors[:email]).to include('has already been taken')
#     end

#     it 'should be invalid when email is nil' do
#       user.email = nil
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:email)
#     end

#     it 'should be invalid when password is nil' do
#       user.password = nil
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:password)
#     end

#     it 'should be invalid when password is long enough' do
#       user.password = 'abc@1'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:password)
#       expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
#     end

#     it 'should be invalid when password has no letters' do
#       user.password = '12345678@'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:password)
#       expect(user.errors[:password]).to include('Password must have at least 1 letter')
#     end

#     it 'should be invalid when password has no numbers' do
#       user.password = 'abcdefghi@'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:password)
#       expect(user.errors[:password]).to include('Password must have at least 1 number')
#     end

#     it 'should be invalid when password has no special characters' do
#       user.password = 'abcdefghi1'
#       user.save
#       expect(user).to be_invalid
#       expect(user.errors).to include(:password)
#       expect(user.errors[:password]).to include('Password must have at least 1 special character')
#     end
#   end

#   describe 'Validations' do
#   end

#   describe 'Scopes' do
#   end

#   describe 'Callbacks' do
#   end

#   describe 'Relations' do
#   end
# end
