require 'spec_helper'

describe "a test" do
  it "should not freeze" do
    sleep 5
    true.should be_true
  end
end