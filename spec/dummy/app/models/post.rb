class Post < ActiveRecord::Base
  include WorkflowActiverecord

  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  DRAFT = 'draft'
  REVIEWED = 'reviewed'
  PUBLISHED = 'published'
  ARCHIVED = 'archived'

  workflow do
    state DRAFT do
      event :peer_review, transitions_to: REVIEWED
    end
    state REVIEWED do
      event :publish, transitions_to: PUBLISHED
    end
    state PUBLISHED do
      event :archive, transitions_to: ARCHIVED
    end
    state ARCHIVED do
      event :reopen, transitions_to: DRAFT
    end
  end
end
