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

  def formatted_talk(talk, url)
    %{
      <h4><a href="#{url}">#{talk.title.truncate(65)}</a></h4>
      <div class='meta'>Updated #{talk.updated_at.to_s(:concise)}</div>
      <blockquote>#{talk.abstracts.first.summary.truncate(150) if talk.abstracts.present?}</blockquote>
    }.html_safe
  end

  def icon_for(user, attribute)
    user.send("has_#{attribute.to_s}?") ? 'icon-ok' : 'icon-star'
  end

  def stat_block(header, body, args={})
    %{<div class="stat"><div class="stat-label">#{header}</div><div class="stat-content well #{args[:class]}">#{body}</div></div>}.html_safe
  end

end
