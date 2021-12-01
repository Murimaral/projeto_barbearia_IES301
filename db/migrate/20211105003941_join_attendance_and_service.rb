class JoinAttendanceAndService < ActiveRecord::Migration[6.1]
  def change
    create_join_table :services, :employees do |t|
      t.index :service_id
      t.index :employee_id
    end
  end
end
