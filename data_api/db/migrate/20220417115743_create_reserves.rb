class CreateReserves < ActiveRecord::Migration[6.1]
  def change
    create_table :reserves do |t|
      t.references :ticket, null: false, foreign_key: true
      t.datetime :time_start, null: false
      t.datetime :time_end, null: false

    end
  end
end
