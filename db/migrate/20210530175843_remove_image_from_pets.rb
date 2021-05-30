class RemoveImageFromPets < ActiveRecord::Migration[6.1]
  def change
    remove_column :pets, :image, :string
  end
end
