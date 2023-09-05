class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: { message: "Content can’t be blank" }
end
