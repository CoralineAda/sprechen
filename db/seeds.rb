Conference.delete_all
Talk.delete_all
Abstract.delete_all
Proposal.delete_all

user = User.first || User.create(:name => 'Sylvester Stallone')

user.bios.create(
  :text => 'A truly bad actor',
  :photo => 'http://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Flickr_-_nicogenin_-_66me_Festival_de_Venise_(Mostra)_-_Sylvester_Stallone_(26).jpg/220px-Flickr_-_nicogenin_-_66me_Festival_de_Venise_(Mostra)_-_Sylvester_Stallone_(26).jpg'
)

user.conferences.create(:name => 'Smokehouse Conference', :start_date => Date.today + 1.month)
user.conferences.create(:name => 'Firehouse Conference', :start_date => Date.today + 2.months)

# First talk

talk1 = user.talks.create(:title => 'So, uh')

talk1.abstracts.create(
  :summary => 'Yeah, this is pretty much Sylvester talking his talk',
  :full_text => 'Lots of long, boring text about this talk.'
)

user.proposals.create(
  :conference => user.conferences.first,
  :talk => talk1,
  :abstract => talk1.abstracts.first,
  :accepted => false,
  :submitted_at => Date.today - 1.month
)

# Second talk

talk2 = user.talks.create(:title => 'How Rocky Won')

talk2.abstracts.create(
  :summary => "It's the eye! Of the tiger!",
  :full_text => 'Lots more long, boring text...'
)

user.proposals.create(
  :conference => user.conferences.last,
  :talk => talk2,
  :abstract => talk2.abstracts.first,
  :accepted => true,
  :submitted_at => Date.today - 1.week
)