class Dashboard

  attr_accessor :user_id

  def initialize(args={})
    self.user_id = args[:user_id]
  end

  def accepted_talks
    user.proposals.accepted
  end

  def submitted_talks
    user.proposals.submitted
  end

  def upcoming_conferences
    user.conferences.upcoming
  end

  def user
    self.user_id
    @user ||= User.find(self.user_id)
  end

end
