set :output, "log/cron_log.log"
set :environment, 'development'

every 1.day, at: '8:00 am' do
  rake 'indicators:import_indicators'
  only: [:monday, :tuesday, :wednesday, :thursday, :friday]
end

every 1.day, at: '7:00 am' do
  rake 'tokens:clear_inative_tokens'
end
