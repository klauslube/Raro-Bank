namespace :indicators do
  desc 'Import indicators and update investment profits'
  task import_indicators: :environment do
    IndicatorService.import_indicators
    Rake::Task['investments:update_profits'].invoke
  end
end
