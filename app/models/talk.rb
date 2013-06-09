class Talk

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :deck_location

  belongs_to  :user
  has_and_belongs_to_many  :proposals
  has_one     :abstract

end