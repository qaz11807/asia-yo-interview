class CreateExchangeRate < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_rates do |t|
      t.references :source, index: true, foreign_key: { to_table: :currencies }
      t.references :target, index: true, foreign_key: { to_table: :currencies }
      t.float     :rate

      t.timestamps
    end
  end
end
