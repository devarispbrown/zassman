class AddImageRemoteUrlToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :image_remote_url, :string
  end
end
