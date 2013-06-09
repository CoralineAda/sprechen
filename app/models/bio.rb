class Bio

  include Mongoid::Document
  include Mongoid::Timestamps

  field :text
  field :photo

  belongs_to :user

  def photo
    @photo ||= user.avatar
  end

end