class Comment < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates :body,    presence: true
  validates :user_id, presence: true
  validates :show_id, presence: true

  def time_created
    created_at.strftime('%B %d, %Y - %I:%M%p')
  end

  def time_updated
    updated_at.strftime('%B %d, %Y - %I:%M%p')
  end
end
