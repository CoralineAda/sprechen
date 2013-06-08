class Proposal

  include Mongoid::Document
  include Mongoid::Timestamps

  field :working_title
  field :alternate_title
  field :synapsis
  field :is_draft

end