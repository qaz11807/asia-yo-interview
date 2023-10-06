class ExchangeRate < ApplicationRecord
  belongs_to :source, class_name: 'Currency', foreign_key: 'source_id'
  belongs_to :target, class_name: 'Currency', foreign_key: 'target_id'
end
