class Note < ApplicationRecord
  belongs_to :user
  validates :note, presence: true
  validates :created_by, presence: true
end
