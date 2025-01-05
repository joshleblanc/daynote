class AddAdminModeToSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :settings, :admin_mode, :boolean, default: false
  end
end
