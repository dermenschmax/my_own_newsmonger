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
    
    s.vote()
    s.votes.should eq 1
  end
  
  
  # voting doesn't affect others
  it "is sure that voting is isolated" do
    s1 = FactoryGirl.create(:story, title: "story 1")
    s2 = FactoryGirl.create(:story, title: "story 2")
    
    s1.votes.should eq 0
    s2.votes.should eq 0
    
    s1.vote()
    s1.votes.should eq 1
    s2.votes.should eq 0
  end


  it "can add a comment" do
    s = FactoryGirl.create(:story)
    
    s.comments.count().should eq 0
    
    s.add_comment("Hello world, first comment", "me")
    
    s.comments.count().should eq 1
  end


  it "counts the comments in comment_count" do
    s = FactoryGirl.create(:story)
    s.comment_count.should eq 0
    
    s.add_comment("Hello world", "somebody")
    
    s.comment_count.should eq 1
  end
  
  
  it "can remove a comment" do
    s = FactoryGirl.create(:story)
    s.add_comment("Hello world", "somebody")
    delete_me = s.comments.first()
    s.save!
    
    s1 = Story.find(s.id)
    s1.title.should eq s.title
    s1.id.should eq s.id
    
    deleted_this = s1.delete_comment(delete_me.id)
    deleted_this.should be_an_instance_of(Comment)
    deleted_this.id.should eq delete_me.id
    
    s1.comment_count.should eq 0
  end
  
  # Tests if we can remove a comment even if we have only a string that holds
  # the id of the comment.
  #
  # Exactly that happens when we feed the method directly from params[:id]
  it "removes a comment even with a string-id" do
    s = FactoryGirl.create(:story)
    c = s.add_comment("hello world", "someone")
    c_id = c.id.to_s
    
    s.comment_count.should eq 1
    c_deleted = s.delete_comment(c_id)
    c_deleted.id.should eq c.id
    
    s.comment_count.should eq 0
  end


  # TODO: specs
  #  - voting
  #    -> each user can vote only once
  #  - sorting (basierend auf dem votes-Wert)


end
