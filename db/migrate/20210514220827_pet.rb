class Pet < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :species
      t.integer :sex
      t.string :breed
      t.string :color
      t.string :image
      t.text :details
      t.string :city
      t.string :state
      t.integer :status
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
