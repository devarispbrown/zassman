class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :box_link
      t.string :invision_link
      t.text :css
      t.string :name

      t.timestamps
    end
  end
end
