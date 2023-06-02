require 'rails_helper'

RSpec.describe Admin::InvestmentsController, type: :controller do
  let(:admin) { create(:user_confirmed, role: :admin) }

  before :each do
    sign_in admin
  end

  it 'should respond with 200' do
    get :index
    expect(response).to have_http_status(200)
  end
end
