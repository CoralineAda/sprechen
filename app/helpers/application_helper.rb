module ApplicationHelper

  def formatted_bio(bio)
    text = "<h4>#{bio.label}</h4>"
    text << "<p>#{bio.content.to_s.truncate(150)}</p>"
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

  def formatted_event(event)
    %{
      <h4><a href="#{event.url}" target="_new">#{event.name}</a></h4>
      <p>#{event.sanitized_location}</p>
      <p>#{event.start_date.to_s(:concise)} - #{event.end_date.to_s(:concise)}</p>
    }.html_safe
  end

  def formatted_proposal(proposal)
    %{
      <em>#{proposal.talk.title}</em><br />
      #{formatted_conference(proposal.conference)}
    }.html_safe
  end

  def formatted_talk(talk, url)
    %{
      <h4><a href="#{url}">#{talk.title.truncate(60)}</a></h4>
      <blockquote>#{talk.abstracts.first.summary.truncate(100) if talk.abstracts.present?}</blockquote>
    }.html_safe
  end

  def branding
    %{
        Sprechen.Me
       <i class='icon-comment' style='margin-top: 0em;'></i>
    }
  end

  def icon_for(user, attribute)
    user.send("has_#{attribute.to_s}?") ? 'icon-ok' : 'icon-star'
  end

  def stat_block(header, body, args={})
    %{<div class="stat"><div class="stat-label">#{header}</div><div class="stat-content well #{args[:class]}">#{body}</div></div>}.html_safe
  end

end
