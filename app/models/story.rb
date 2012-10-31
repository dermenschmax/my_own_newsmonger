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
