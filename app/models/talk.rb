class Talk

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :deck_location

  belongs_to  :user
  has_many  :proposals
  has_many  :abstracts

end