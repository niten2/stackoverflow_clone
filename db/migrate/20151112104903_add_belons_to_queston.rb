class AddBelonsToQueston < ActiveRecord::Migration
  def change
      add_column :questions, :user_id, :integer, index: true
      add_column :answers, :user_id, :integer, index: true
  end
end

