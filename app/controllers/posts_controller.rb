class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:comments)
  end

  # GET /posts/1 or /posts/1.json
  def show
    add_breadcrumb @post.id, post_path(@post)
  end

  # GET /posts/new
  def new
    add_breadcrumb 'new'
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    add_breadcrumb @post.id, post_path(@post)
    add_breadcrumb 'edit'
  end

  # POST /posts or /posts.json
  def create
    add_breadcrumb 'new'
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    add_breadcrumb 'edit'
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_url, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content)
    end
end
