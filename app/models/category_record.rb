class CategoryRecord < ApplicationRecord
  self.table_name = :categories_records
  belongs_to :category
  belongs_to :record
end