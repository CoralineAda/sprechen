class Proposal

  include Mongoid::Document
  include Mongoid::Timestamps

  field :submitted_at, :type => Date
  field :presented_at, :type => Date
  field :accepted,     :type => Boolean

  belongs_to :conference
  belongs_to :talk
  belongs_to :user
  has_one :bio
  has_one :abstract

  scope :accepted,  where(:accepted => true)
  scope :rejected,  where(:accepted => false)
  scope :submitted, excludes(:submitted_at => nil)

  def self.awaiting_approval
    submitted.where(:accepted => nil)
  end

  def presented?
    self.presented_at.present?
  end

end
