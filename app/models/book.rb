class Book < ApplicationRecord
    enum status: ["Borrow", "On_shelf"]
    validates :title, presence: true
end
