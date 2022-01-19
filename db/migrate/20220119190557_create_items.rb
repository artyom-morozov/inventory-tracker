class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title
      t.float :price
      t.integer :count
      t.string :description

      t.timestamps
    end
  end
end
