class Talk

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :deck_location

  belongs_to  :user
  has_many  :proposals
  has_many  :abstracts

  def has_details?
    self.deck_location || self.abstracts.first
  end

  def history
    TalkHistory.new(self.id)
  end

end