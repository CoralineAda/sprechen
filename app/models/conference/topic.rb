class Conference::Topic

  include Mongoid::Document

  field :name

  index({ name: 1 }, { unique: true, name: "name_index" })

  validates_presence_of   :name
  validates_uniqueness_of :name

  def self.terms_for(term)
    term.to_s.size > 1 && where(:name => /^#{term}/).limit(50).pluck(:name).sort
  end

end
