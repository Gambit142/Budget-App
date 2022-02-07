class Record < ApplicationRecord
  belongs_to :user
  has_many :categories_records
  has_many :categories, through: :categories_records
end
