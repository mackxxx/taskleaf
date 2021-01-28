class AddUserIdToTasks < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :task, :user ,null: false, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
