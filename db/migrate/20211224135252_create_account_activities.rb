class CreateAccountActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :account_activities do |t|
      t.string :remarks
      t.integer :price
      t.integer :balance
      t.string :give_take
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
