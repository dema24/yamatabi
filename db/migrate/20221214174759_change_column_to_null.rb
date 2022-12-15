class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :relationships, :follower_id, true
    change_column_null :relationships, :followed_id, true
  end

  def down
    change_column_null :relationships, :follower_id, false
    change_column_null :relationships, :followed_id, false
  end
end
