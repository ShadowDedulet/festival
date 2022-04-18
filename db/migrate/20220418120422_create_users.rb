class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :fcs
      t.integer :age
      t.integer :document_type, default: 0
      t.string :document_number
      t.integer :role, default: 0
      t.string :login
      t.string :password

      t.timestamps
    end
  end
end
