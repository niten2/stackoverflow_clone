class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer    :value, null:false
      t.references :user, index: true
      t.references :votable, index: true, polymorphic: true

      t.timestamps null: false
    end
    add_foreign_key :votes, :users
  end
end
