namespace :indicators do
  desc 'TODO'
  task import_indicators: :environment do
    IndicatorService.import_indicators
  end
end
