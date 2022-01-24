class Item < ApplicationRecord
    belongs_to :user
    has_one_attached :photo, dependent: :destroy
    has_many :categorized_items, dependent: :delete_all
    has_many :categories, :through => :categorized_items
end
