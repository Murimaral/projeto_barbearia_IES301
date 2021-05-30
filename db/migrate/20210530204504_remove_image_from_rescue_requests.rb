class RemoveImageFromRescueRequests < ActiveRecord::Migration[6.1]
  def change
    remove_column :rescue_requests, :image, :string
  end
end
