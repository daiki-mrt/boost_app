class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :following_id
      t.integer :follower_id
      t.timestamps
      t.index [:following_id, :follower_id], unique: true
    end
  end
end
