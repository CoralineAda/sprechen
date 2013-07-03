class Speaker::Calendar

  attr_accessor :subscriber

  def initialize(subscriber)
    self.subscriber = subscriber
  end

  def events
    subscriber.events.asc(:start_date)
  end

end