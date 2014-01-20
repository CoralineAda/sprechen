class Talk::Proposal

  include Mongoid::Document
  include Mongoid::Timestamps

  field :submitted_at,      :type => Date
  field :accepted,          :type => Boolean
  field :status_updated_at, :type => Date

  belongs_to :conference, :class_name => 'Conference::Conference'
  belongs_to :talk, :class_name => 'Talk::Talk'
  belongs_to :user
  has_one :bio, :class_name => 'Speaker::Bio'
  has_one :abstract, :class_name => 'Talk::Abstract'

  scope :accepted,  -> { where(:accepted => true) }
  scope :rejected,  -> { where(:accepted => false) }
  scope :submitted, -> { excludes(:submitted_at => nil) }

  def self.awaiting_approval
    submitted.where(:accepted => nil)
  end

  def accepted?
    self.accepted
  end

  def rejected?
    self.accepted.present? && ! self.accepted
  end

  def presented?
    self.conference.end_date < Date.today
  end

end
