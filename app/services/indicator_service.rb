class IndicatorService
  require 'rest-client'
  require 'json'

  API_ENDPOINTS = {
    cdi: 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.12/dados/ultimos/1?formato=json',
    selic: 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados/ultimos/1?formato=json',
    ipca: 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.10844/dados/ultimos/1?formato=json'
  }.freeze

  def self.import_indicators
    API_ENDPOINTS.each do |name, url|
      response = RestClient.get(url)
      data = JSON.parse(response.body)
      rate = data.first['valor'].to_f
      date = data.first['data']

      adjust_rate = calculate_rate(rate, name)

      save_indicator(name, date, adjust_rate)
    end
  end

  def self.calculate_rate(rate, name)
    name == :ipca ? (rate / 100) / 30 : rate / 100
  end

  def self.save_indicator(name, date, rate)
    indicator = Indicator.find_or_initialize_by(name: name.to_s.upcase, rate_date: date)
    indicator.rate = rate
    indicator.rate_date = date
    indicator.save
  end
end
