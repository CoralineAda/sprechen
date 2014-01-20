class Speaker::Calendar

  attr_accessor :subscriber

  def initialize(subscriber)
    self.subscriber = subscriber
  end

  def conferences
    subscriber.conferences.asc(:start_date)
  end

end