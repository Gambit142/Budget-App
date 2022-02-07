class Category < ApplicationRecord
  belongs_to :user
  has_many :categories_records
  has_many :records, through: :categories_records
end
