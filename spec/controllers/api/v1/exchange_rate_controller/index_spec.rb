require 'rails_helper'

RSpec.describe 'api/v1/exchange_rate', type: :request do
  before(:each) do
    mock_currency_and_excahnge_rate

    @path = '/api/v1/exchange_rate'
  end

  describe 'exchange the currency' do
    it 'should return code 200' do
      params = {
        source: 'USD',
        target: 'JPY',
        amount: '$1,525'
      }

      get(@path, params: params)

      expect(response).to have_http_status(:ok)
      expect(json['status']).to eq('Success')
      expect(json['amount']).to eq('$170,496.53')
    end

    it 'should return code 404 when target or source currency not supported' do
      params = {
        source: 'RMB',
        target: 'JPY',
        amount: '$1,525'
      }

      get(@path, params: params)

      expect(response).to have_http_status(404)
      expect(json['status']).to eq('Failed')
      expect(json['message']).to eq('Currency not supproted!')
    end

    it 'should return code 404 when exchange rate not supported' do
      new_currency = FactoryBot.create(:currency)
      params = {
        source: new_currency.name,
        target: 'JPY',
        amount: '$1,525'
      }

      get(@path, params: params)

      expect(response).to have_http_status(404)
      expect(json['status']).to eq('Failed')
      expect(json['message']).to eq('Exchange rate not supproted!')
    end
  end
end
