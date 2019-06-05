class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :workflow_state, null: false

      t.timestamps
    end
  end
end
