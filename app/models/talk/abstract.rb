class Talk::Abstract

  include Mongoid::Document
  include Mongoid::Timestamps

  field :summary
  field :full_text

  belongs_to :proposal, :class_name => 'Talk::Proposal'
  belongs_to :talk, :class_name => 'Talk::Talk'

  def summary
    self[:summary].present? && self[:summary] || self.full_text.to_s.truncate(200)
  end

end