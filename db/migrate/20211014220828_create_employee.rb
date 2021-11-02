class CreateEmployee < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phone
      t.integer :gender
      t.integer :status, default: 0
      t.text :email
      t.text :document
      t.text :address
      t.date :birthdate

      t.timestamps
    end
  end
end
