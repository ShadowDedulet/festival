class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.integer :action
      t.string :fio
      t.boolean :status
      t.integer :ticket_id

      t.timestamps
    end
  end
end
