class Conference

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :tags,        :type => Array, :default => []
  field :start_date,  :type => Date
  field :end_date,    :type => Date
  field :venue
  field :address
  field :city
  field :state
  field :country
  field :email
  field :homepage

  has_many :proposals

end