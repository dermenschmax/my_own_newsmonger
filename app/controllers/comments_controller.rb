class CommentsController < ApplicationController
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /stories/:story_id/comments/new
  # GET /stories/:story_id/comments/new.json
  def new
    @comment = Comment.new
    @story = Story.find(params[:story_id])

    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end


  # POST /comments
  # POST /comments.json
  def create
    @story = Story.find(params[:story_id])
    
    text = params[:comment][:text]
    user_name = params[:comment][:user_name]
    @comment = @story.add_comment(text, user_name)

    respond_to do |format|
      if @story.save
        format.html { redirect_to stories_path, notice: 'comment was successfully created.' }
        format.json { render json: @story, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    
    logger.debug("[Comments::destory] params[:story_id] #{params[:story_id]}")
    logger.debug("[Comments::destory] params[:id] #{params[:id]}")
    
    @story = Story.find(params[:story_id])
    @comment = @story.delete_comment(params[:id])
    @story.save()

    respond_to do |format|
      format.html { redirect_to @story }
      format.json { head :no_content }
    end
  end

  
end
