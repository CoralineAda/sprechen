class Bio

  include Mongoid::Document
  include Mongoid::Timestamps

  field :label
  field :content
  field :photo

  belongs_to :user

end