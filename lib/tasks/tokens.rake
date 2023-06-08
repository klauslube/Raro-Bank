namespace :tokens do
  desc 'Atualiza status dos tokens'
  task 'tokens:update_status' => :environment do
    TokenService.update_tokens_status
  end
end
