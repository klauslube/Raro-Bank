require "rails_helper"

RSpec.describe "Routes", type: :routing do
  describe "when user not authenticated" do
    it "should route be available devise sessions#new" do
      expect(get: "/users/sign_in").to route_to("devise/sessions#new")
    end

    it "should route be available devise sessions#create" do
      expect(post: "/users/sign_in").to route_to("devise/sessions#create")
    end

    it "should route be available devise registrations#new" do
      expect(get: "/users/sign_up").to route_to("users/registrations#new")
    end

    it "should route be available devise registrations#create" do
      expect(post: "/users").to route_to("users/registrations#create")
    end

    it "should route be available devise passwords#new" do
      expect(get: "/users/password/new").to route_to("devise/passwords#new")
    end
  end
end
