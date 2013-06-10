class TalkHistory

  attr_reader :talk_id

  def initialize(talk_id)
    @talk_id = talk_id
  end

  def talk
    @talk ||= Talk.find(self.talk_id)
  end

  def events
    talk_events | proposal_events
  end

  def proposal_events
    events = []
    talk.proposals.each do |proposal|
      events << "#{proposal.created_at.to_s(:concise)}: Proposal submitted to #{proposal.conference.name}"
      events << "#{proposal.status_updated_at.to_s(:concise)}: Talk rejected by #{proposal.conference.name}" if proposal.rejected?
      events << "#{proposal.status_updated_at.to_s(:concise)}: Proposal accepted by #{proposal.conference.name}" if proposal.accepted? && proposal.status_updated_at
      events << "#{proposal.conference.end_date.to_s(:concise)}: Talk given at #{proposal.conference.name}" if proposal.presented?
    end
    events
  end

  def talk_events
    ["#{talk.created_at.to_s(:concise)}: Talk created"]
  end

end