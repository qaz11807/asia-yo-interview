require 'rails_helper'

RSpec.describe '/', type: :request do
  before(:each) do
    @path = '/'
  end

  describe 'Test api' do
    it 'should return code 200' do
      get(@path)
      expect(response).to have_http_status(:ok)
      expect(json['data']).to eq('hello world!')
    end
  end
end
