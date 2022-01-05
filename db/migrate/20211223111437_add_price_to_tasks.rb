class AddPriceToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :price, :integer
  end
end
