class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :space, foreign_key: true
      t.text :text, null: false
      t.timestamps
    end
  end
end
