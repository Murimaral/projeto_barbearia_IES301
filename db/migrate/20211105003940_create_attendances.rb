class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :customer_id
      t.integer :employee_id
      t.integer :service_id

      t.timestamps
    end
    add_index :attendances, :customer_id
    add_index :attendances, :employee_id
    add_index :attendances, :service_id
  end
end
