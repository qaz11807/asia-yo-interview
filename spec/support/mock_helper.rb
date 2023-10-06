# frozen_string_literal: true

module MockHelper
  def mock_currency_and_excahnge_rate
    raw_data = {
      "currencies": {
        "TWD": {
          "TWD": 1,
          "JPY": 3.669,
          "USD": 0.03281
        },
        "JPY": {
          "TWD": 0.26956,
          "JPY": 1,
          "USD": 0.00885
        },
        "USD": {
          "TWD": 30.444,
          "JPY": 111.801,
          "USD": 1
        }
      }
    }.as_json

    raw_data['currencies'].each do |source_currency_name, target_currencies|
      source_currency = Currency.find_or_create_by(name: source_currency_name.upcase)

      target_currencies.each do |target_currency_name, rate|
        target_currency = Currency.find_or_create_by(name: target_currency_name.upcase)

        exchange_rate = ExchangeRate.find_or_initialize_by(source_id: source_currency.id, target_id: target_currency.id)
        exchange_rate.rate = rate
        exchange_rate.save!
      end
    end
  end
end
