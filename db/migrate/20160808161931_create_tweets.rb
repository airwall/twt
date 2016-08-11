class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :body, limit: 140

      t.timestamps
    end
    add_index :tweets, :user_id
  end
end
