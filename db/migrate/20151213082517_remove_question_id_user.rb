class RemoveQuestionIdUser < ActiveRecord::Migration
  def change
    remove_column :users, :question_id
  end
end
