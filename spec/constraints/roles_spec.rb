require 'rails_helper'

describe 'RoleConstraint' do
  context 'admin user routes' do
    let(:user) { create(:user, role: :admin) }

    it 'should returns true for admin role' do
      request = double(env: { 'warden' => double(user: user) })
      constraint = RoleConstraint.new([:admin])
      expect(constraint.matches?(request)).to be_truthy
    end

    it 'should returns false for non-admin role' do
      user = create(:user, role: :premium)
      request = double(env: { 'warden' => double(user: user) })
      constraint = RoleConstraint.new([:admin])
      expect(constraint.matches?(request)).to be_falsey
    end
  end

  context 'free user routes' do
    let(:user) { create(:user, role: :free) }

    it 'should returns true for free role' do
      request = double(env: { 'warden' => double(user: user) })
      constraint = RoleConstraint.new([:free])
      expect(constraint.matches?(request)).to be_truthy
    end

    it 'should returns false for non-free role' do
      user = create(:user, role: :admin)
      request = double(env: { 'warden' => double(user: user) })
      constraint = RoleConstraint.new([:free])
      expect(constraint.matches?(request)).to be_falsey
    end
  end

  context 'premium user routes' do
    let(:user) { create(:user, role: :premium) }

    it 'should returns true for premium role' do
      request = double(env: { 'warden' => double(user: user) })
      constraint = RoleConstraint.new([:premium])
      expect(constraint.matches?(request)).to be_truthy
    end

    it 'should returns false for non-premium role' do
      user = create(:user, role: :admin)
      request = double(env: { 'warden' => double(user: user) })
      constraint = RoleConstraint.new([:premium])
      expect(constraint.matches?(request)).to be_falsey
    end
  end
end