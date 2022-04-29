class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, index: true, null: false
      t.datetime :date_start, null: false
      t.datetime :date_end, null: false

    end
  end
end
