class RenameListCompletedToUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :list_completed, :list_readied
  end
end
