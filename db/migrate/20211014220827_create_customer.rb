class CreateCustomer < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.text :email
      t.text :details
      t.date :birthdate

      t.timestamps
    end
  end
end
