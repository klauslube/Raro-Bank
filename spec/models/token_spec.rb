RSpec.describe Token, type: :model do
  describe 'associations' do
    it { should belong_to(:transfer).class_name('Transaction').with_foreign_key(:transaction_id).dependent(:destroy).inverse_of(:token) }
  end

  describe 'validations' do
    it { should validate_presence_of(:code) }
  end
end
