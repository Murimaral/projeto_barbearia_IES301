class CreateRescueRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :rescue_requests do |t|
      t.integer :owner_id
      t.integer :rescuer_id
      t.integer :found_pet_id
      t.integer :lost_pet_id
      t.boolean :created_by_owner
      t.string :image
      t.text :message
      t.text :reply
      t.integer :status, default: true

      t.timestamps
    end
  end
end
