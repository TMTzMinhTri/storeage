class Folder < ApplicationRecord
  has_many_attached :files

  class << self 
    def file_path(file)
      ActiveStorage::Blob.service.path_for(file.key)
    end
  end
end
