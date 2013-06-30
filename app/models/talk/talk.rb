class Talk::Talk

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :deck_location
  field :archived, :type => Boolean, :default => false

  belongs_to  :user
  has_many  :proposals, :class_name => 'Talk::Proposal'
  has_many  :abstracts, :class_name => 'Talk::Abstract'

  def has_details?
    self.deck_location || self.abstracts.first
  end

  def history
    Talk::TalkHistory.new(self.id)
  end

  def recently_created?
    self.created_at > Date.today - 2.months
  end

  def recently_updated?
    self.updated_at > Date.today - 1.month
  end

  def submitted?
    self.proposals.present?
  end

  def accepted?
    self.proposals.accepted.present?
  end

  def rejected?
    self.proposals.rejected.present?
  end

  def tags
    tags = []
    tags << "recent"      if recently_created?
    tags << "updated"     if recently_updated?
    tags << "active"      unless self.archived?
    tags << "archived"    if self.archived?
    tags << "unsubmitted" unless self.submitted?
    tags << "submitted"   if self.submitted?
    tags << "accepted"    if self.accepted?
    tags << "rejected"    if self.rejected?
    tags
  end

end