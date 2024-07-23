class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :find_post
  before_action :set_breadcrumb

  # GET /comments or /comments.json
  def index
    add_breadcrumb 'comments'
    @comments = @post.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
    add_breadcrumb 'show'
  end

  # GET /comments/new
  def new
    add_breadcrumb 'new'
    @comment = @post.comments.new
  end

  # GET /comments/1/edit
  def edit
    add_breadcrumb 'edit'
  end

  # POST /comments or /comments.json
  def create
    add_breadcrumb 'new'
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_comments_url(@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    add_breadcrumb 'edit'

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_comments_url(@post), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to post_comments_url(@post), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end

    def find_post
      @post = Post.find(params[:post_id])
    end

    def set_breadcrumb
      add_breadcrumb @post.id, post_path(@post)
    end
end
