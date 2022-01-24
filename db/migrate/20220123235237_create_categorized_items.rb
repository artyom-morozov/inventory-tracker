class CreateCategorizedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :categorized_items do |t|
      t.belongs_to :item, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
