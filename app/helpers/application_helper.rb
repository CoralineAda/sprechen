module ApplicationHelper

  def flash_class(level)
    case level
    when :notice; "alert alert-info"
    when :success; "alert alert-success"
    when :error; "alert alert-error"
    when :alert; "alert alert-error"
    end
  end

  def formatted_conference(conference)
    %{
      #{conference.name} in #{conference.city}, #{conference.state}<br />
      #{conference.start_date} - #{conference.end_date}
    }
  end

  def formatted_proposal(proposal)
    %{
      <em>#{proposal.talk.title}</em><br />
      #{formatted_conference(proposal.conference)}
    }
  end

end
