namespace :tokens do
  desc 'Limpa tokens inativos do banco'
  task clear_inative_tokens: :environment do
    Transactions::TokenService.new.destroy_inative_tokens
  end
end
