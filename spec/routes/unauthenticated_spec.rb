require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
   describe 'Unauthenticated' do
    it 'should routes to devise sessions#new' do
      expect(get: '/users/sign_in').to route_to('devise/sessions#new')
    end

    it 'should routes to devise sessions#create' do
      expect(post: '/users/sign_in').to route_to('devise/sessions#create')
    end

    it 'should routes to devise registrations#new' do
      expect(get: '/users/sign_up').to route_to('devise/registrations#new')
    end

    it 'should routes to devise registrations#create' do
      expect(post: '/users').to route_to('devise/registrations#create')
    end

    it 'should routes to devise passwords#new' do
      expect(get: '/users/password/new').to route_to('devise/passwords#new')
    end
  end
end
