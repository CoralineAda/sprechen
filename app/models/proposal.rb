class Proposal

  include Mongoid::Document
  include Mongoid::Timestamps

  field :submitted_at, :type => Date
  field :presented_at, :type => Date
  field :accepted,     :type => Boolean

  belongs_to :conference
  has_one :talk
  has_one :bio
  has_one :abstract

  def presented?
    self.presented_at.present?
  end

end
