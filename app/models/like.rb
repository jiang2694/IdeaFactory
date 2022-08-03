class Like < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  # validates(:question_id, uniqueness: true) #wrong way!
  validates(:idea_id, uniqueness: {scope: :user_id, message: "Has already been liked!"})
end
