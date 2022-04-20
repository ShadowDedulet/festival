class RenameActionToActionTypeInActions < ActiveRecord::Migration[6.1]
  def change
    rename_column :actions, :action, :action_type
  end
end
