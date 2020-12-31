class Folder < ApplicationRecord
  has_many_attached :files
end
