require 'spec_helper'

describe Conference::Conference do

  describe "from" do

    it "requires an ICS document" do
      Conference::Conference.from(nil).should be_nil
    end

    it "it returns an array of conferences"

  end

end
