class Abstract

  include Mongoid::Document
  include Mongoid::Timestamps

  field :summary
  field :full_text

  belongs_to :proposal
  belongs_to :talk

  def summary
    self[:summary] || self.full_text.to_s.truncate(200)
  end

end