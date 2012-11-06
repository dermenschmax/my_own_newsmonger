require 'spec_helper'

describe Story do
  
  it "can be instantiated" do
    Story.new.should be_an_instance_of(Story)
  end
  
  it "can be saved successfully" do
    Story.create.should be_persisted
  end


end
