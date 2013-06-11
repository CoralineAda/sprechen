module ApplicationHelper

  def formatted_bio(bio)
    text = "<em>#{bio.label}</em><br />"
    text << bio.content.to_s
    text.html_safe
  end

  def formatted_conference(conference)
    text = "#{conference.name}"
    text << " in #{conference.city}" if conference.city
    text << ", #{conference.state}" if conference.city && conference.state
    text << "<br />"
    text << conference.start_date.to_s(:concise)
    text << "- #{conference.end_date.to_s(:concise)}" if conference.end_date
    text.html_safe
  end

  def formatted_proposal(proposal)
    %{
      <em>#{proposal.talk.title}</em><br />
      #{formatted_conference(proposal.conference)}
    }.html_safe
  end

  def formatted_talk(talk)
    text = "<em>#{talk.title}</em><br />"
    text << "<span class='meta'>#{talk.updated_at.to_s(:concise)}</span>"
    text << "<br /><br />"
    text << talk.abstracts.first.summary.truncate(100) if talk.abstracts.present?
    text.html_safe
  end

  def icon_for(user, attribute)
    user.send("has_#{attribute.to_s}?") ? 'icon-ok' : 'icon-star'
  end

  def stat_block(header, body, args={})
    %{<div class="stat"><div class="stat-label">#{header}</div><div class="stat-content well #{args[:class]}">#{body}</div></div>}.html_safe
  end

end
