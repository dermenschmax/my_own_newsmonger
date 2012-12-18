# ---------------------------------------------------------------------
# The Story is the center of this application. It models a text of interest.
# It contains a title, the text itself and a user_name. All three are
# necessary.
#
# Stories may have comments. For details see Comment class
#
# The most important methods are the following:
# 
#   - vote        Vote for a story. Stories are ranked by the number of votes
#   - add_comment Adds a comment (at the end of the list)
# ---------------------------------------------------------------------
class Story
  include MongoMapper::Document

  key :title,     String
  key :text,      String
  
  key :user_name, String
  
  # votes
  #   - we're counting the number (votes) and remember who voted (voters => [user_name, ...])
  #   - we add an index to the voters array
  key :voters,    Array
  key :votes,     Integer, :default => 0
  ensure_index(:voters)
  
  
  timestamps!
  
  
  # comments
  #  - we're storing the number of comments here for display and sorting reasons
  #
  key :comment_count, Integer, :default => 0
  many :comments
  
  
  # Validations
  
  validates_presence_of :title, :text, :user_name
  validates_associated :comments
  
  
  # ---------------------------------------------------------------------
  # Vote for a story.
  #
  # Stories are ranked by the number of votes they get. It's a kind of 'like'.
  # You can vote for any story but only once.
  #
  # The actual vote count is stored in :votes. The number is increased and
  # the user is added to the :voters array.
  # ---------------------------------------------------------------------
  def vote()
    self.votes += 1
  end
  
  
  
  # ---------------------------------------------------------------------
  # Addes a comment
  #
  # The method handles all the things  that have be done to add a comment. Because
  # comments a modeled as embedded objects the parent has to deal with all the
  # details of managing the children.
  #
  # It returns the shiny new comment for display reasons.
  # ---------------------------------------------------------------------
  def add_comment(text, user_name)
    c = Comment.new(:text => text, :user_name => user_name)
    comments << c
    recalc_comment_count()
    
    c
  end
  
  
  # ---------------------------------------------------------------------
  # Deletes a comment
  #
  # Removes the object from the comments array.
  #
  # It returns the deleted comment for display reasons.
  # ---------------------------------------------------------------------  
  def delete_comment(comment_id)
    
    deleted_ones = comments.select{|c| c.id.to_s == comment_id.to_s}
    
    comments.delete_if{|c| c.id.to_s == comment_id.to_s}
    recalc_comment_count()

    
    deleted_ones.first()
  end
  
  
  private
  
  def recalc_comment_count
    self.comment_count = self.comments.count()
  end
  

  #
  ## Note this: ids are of class ObjectId.
  #key :user_id,   ObjectId
  #
  #
  ## Relationships.
  #belongs_to :user

end
