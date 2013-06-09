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

  belongs_to :user
  has_many :proposals

  def self.upcoming
    where(:start_date.gt => Date.today.end_of_day)
  end

  def self.todo
    upcoming.select{|conf| conf.proposals.empty? }
  end

end