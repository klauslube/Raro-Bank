module Transactions
  class TokenUpdateJob < ApplicationJob
    queue_as :default

    def perform
      Transactions::TokenService.new.call
    end
  end
end
