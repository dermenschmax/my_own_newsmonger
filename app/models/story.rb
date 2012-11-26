# ---------------------------------------------------------------------
# The Story is the center of this application. It models a text of interest.
# It contains a title, the text itself and a user_name. All three are
# necessary.
#
# The most important methods are the following:
# 
#   - vote    Vote for a story. Stories are ranked by the number of votes
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
  
  
  validates_presence_of :title, :text, :user_name
  
  
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
    votes += 1
  end
  
  
  
  #key :slug,      String
  #key :voters,    Array
  #key :votes,     Integer, :default => 0
  #key :relevance, Integer, :default => 0
  #
  ## Cached values.
  #key :comment_count, Integer, :default => 0
  #key :username,      String
  #
  ## Note this: ids are of class ObjectId.
  #key :user_id,   ObjectId
  #timestamps!
  #
  ## Relationships.
  #belongs_to :user
  #
  ## Validations.
  #validates_presence_of :title, :url, :user_id

end
