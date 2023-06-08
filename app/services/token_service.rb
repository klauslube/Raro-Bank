class TokenService
  def self.update_tokens_status
    tokens = Token.where(active: true).where('created_at <= ?', 5.minutes.ago)
    tokens.each { |token| token.update(active: false) }
  end
end
