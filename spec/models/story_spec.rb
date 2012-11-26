require 'spec_helper'

describe Story do
  
  it "can be instantiated" do
    Story.new.should be_an_instance_of(Story)
  end
  
  # This tests if the default story created by FactoryGirl is persistable
  it "can be saved successfully" do
    FactoryGirl.create(:story).should be_persisted
  end
  
  # Checks if user_name is validated
  it "needs a title" do
    FactoryGirl.build(:story, title: "").should_not be_valid
  end
  
  # Checks if user_name is validated
  it "needs a text" do
    FactoryGirl.build(:story, text: "").should_not be_valid
  end
  
  # Checks if user_name is validated
  it "needs a user_name" do
    FactoryGirl.build(:story, user_name: "").should_not be_valid
  end
  
  
  # Test the voting
  it "can be voted" do
    s = FactoryGirl.create(:story)
    s.votes.should eq 0
    
    # TODO: Hier weiter
  end


  # TODO: specs für
  #  - das Voten
  #  - user_name
  #  - title
  #  - text
  #  - Sortierung (basierend auf dem votes-Wert)


end
