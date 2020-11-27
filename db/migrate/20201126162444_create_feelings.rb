class CreateFeelings < ActiveRecord::Migration[6.0]
  def change
    create_table :feelings do |t|
      t.string :body
      t.integer :user_id
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
