# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# every 1.day, at: '9:00 am' do
#   runner 'IndicatorService.import_indicators'
# end

set :output, "log/cron_log.log"
set :environment, 'development'

every 1.day, at: '8:00 am' do
  rake 'indicators:import_indicators'
  only: [:monday, :tuesday, :wednesday, :thursday, :friday]
end

# Learn more: http://github.com/javan/whenever
