class Currency < ApplicationRecord
  has_many :exchange_rates, dependent: :destroy
end
