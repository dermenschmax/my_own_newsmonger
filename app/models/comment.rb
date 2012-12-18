# ---------------------------------------------------------------------
# Users are encouraged to comment stories. These comments are modeled
# as an embedded document.
#
# Right now these comments are linear. You can't comment another comment.
# That'll happen in a future version (maybe). And you cannot search for comments
# because it's an embedded document.
#
# A Comment has the following attributes:
#
#   text        what has to be said
#   user_name   ...
# ---------------------------------------------------------------------
class Comment
  include MongoMapper::EmbeddedDocument

  key :text
  key :user_name
  
  timestamps!
  
  validates_presence_of :text, :user_name
end
