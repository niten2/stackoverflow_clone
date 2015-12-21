class AddBelongToUser < ActiveRecord::Migration
  def change
    add_column :users, :question_id, :integer
  end
end
