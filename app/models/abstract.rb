class Abstract

  include Mongoid::Document
  include Mongoid::Timestamps

  field :summary
  field :full_text

  belongs_to :proposal
  belongs_to :talk

end