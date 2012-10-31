class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :devise_users, :bio, :string
    add_column :devise_users, :website, :string
    add_column :devise_users, :slug, :string
    add_index :devise_users, :slug, unique: true
  end
end
