require 'spec_helper'

describe Comment do
  
  it "can be instantiated" do
    Comment.new.should be_an_instance_of(Comment)
  end
  
  
  it "has a valid factory configuration" do
    FactoryGirl.build(:comment).should be_valid
  end
  
  
  it "validates text and user_name" do
    FactoryGirl.build(:comment, :text => nil).should_not be_valid
    FactoryGirl.build(:comment, :user_name => nil).should_not be_valid
  end
  
  
end
