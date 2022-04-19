class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.integer :ticket_type, null: false
      t.integer :status, null: false
      t.integer :start_price, null: false
      t.references :event, null: false, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end
