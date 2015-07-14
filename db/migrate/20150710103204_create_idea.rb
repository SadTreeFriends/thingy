class CreateIdea < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    # Multiple key index: ActiveRecord uses both keys at the same time
    add_index :ideas, [:user_id, :created_at]
  end
end
