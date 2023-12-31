class Api::V1::ExchangeRateController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    key = "#{params['source']}:#{params['target']}"
    cached = Rails.cache.read(key)
    rate = if cached
             cached
           else
             source = Currency.find_by(name: params['source'].upcase)
             target = Currency.find_by(name: params['target'].upcase)
             return error_response(404, message: 'Currency not supproted!') if source.nil? || target.nil?

             exchange_rate = ExchangeRate.find_by(source_id: source.id, target_id: target.id)
             return error_response(404, message: 'Exchange rate not supproted!') if exchange_rate.nil?

             Rails.cache.write(key, exchange_rate.rate)
             exchange_rate.rate
           end

    exchanged_amount = (rate * currency_to_number(params['amount'])).round(2)

    success_response({ amount: number_to_currency(exchanged_amount) })
  end

  private

  def currency_to_number(currency)
    currency.to_s.gsub(/[$,]/, '').to_f
  end
end
