class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_rich_text :description
  has_one_attached :picture

  enum condition: {well_used: 1, barely_used: 2, almost_new: 3, brand_new: 4}
end
