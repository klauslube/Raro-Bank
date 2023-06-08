module Transactions
  class TokenService
    def call
      update_tokens_status
    end

    private

    def update_tokens_status
      tokens = Token.where(active: true).where('created_at <= ?', 5.minutes.ago)
      tokens.each { |token| token.update(active: false) }
    end
  end
end
