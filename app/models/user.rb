class User

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :provider
  field :uid
  field :avatar_url
  field :is_admin, :type => Boolean, :default => false

  has_many :bios
  has_many :conferences
  has_many :proposals
  has_many :talks

  # Class methods ==============================================================

  def self.for_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid.to_s).first || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider   = auth['provider']
      user.uid        = auth['uid']
      user.name       = auth['info']['name']
      user.avatar     = auth['info']['image']
    end
  end

  # Instance methods ===========================================================

  def first_name
    self.name.split.first
  end

  def just_getting_started?
    return true unless has_bio? && has_talks? && has_conferences?
  end

  def has_bio?
    self.bios.count > 0
  end

  def has_talks?
    self.talks.count > 0
  end

  def has_conferences?
    self.conferences.count > 0
  end

  def has_accepted_proposals?
    self.proposals.accepted.count > 0
  end

  def slug
    self.name.gsub(" ","").downcase
  end

end
