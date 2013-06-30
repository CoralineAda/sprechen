class Speaker::Bio

  include Mongoid::Document
  include Mongoid::Timestamps

  field :label
  field :content
  field :photo

  belongs_to :user
  belongs_to :proposal, :class_name => 'Talk::Proposal'

end