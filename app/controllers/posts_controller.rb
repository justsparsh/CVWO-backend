class PostsController < ApplicationController
    before_action :authenticate_user, only: [:index, :update, :destroy, :count, :create]
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :set_user, only: [:index, :count]
    before_action :set_thread, only: [:index, :count]
  
    def index
        page_number = params[:page].to_i.positive? ? params[:page].to_i : 1
        per_page = 5 
    
        if @user
          @posts = @user.posts.order(id: :desc).offset((page_number - 1) * per_page).limit(per_page)
        elsif @thread
          @posts = @thread.posts.order(id: :desc).offset((page_number - 1) * per_page).limit(per_page)
        # else
        #   @posts = Post.order(id: :desc).offset((page_number - 1) * per_page).limit(per_page)
        end
    
        render json: @posts
    end
  
    def show
      render json: @post
    end
  
    def create
      @post = Post.new(post_params)
  
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post.destroy
      render json: { message: 'Thread was successfully destroyed.' }, status: :ok
    end

    def count
      if @user
        total_posts = @user.posts.count
      elsif @thread
        total_posts = @thread.posts.count
      # else
      #   total_posts = Post.count
      end
    
      render json: { total_posts: total_posts }
    end
  
    private

  def authenticate_user
    name = request.headers['Name']
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      decoded_payload = JwtService.decode(token)
      @current_user = User.find(decoded_payload.first['user_id'])
      if name != @current_user.name 
        render json: { error: 'Invalid user authentication' }, status: :unauthorized
        return
      end
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
  
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
        @user = User.find_by(id: params[:userID])
    end

    def set_thread
      @thread = MessageThread.find_by(id: params[:threadID])
    end
  
    def post_params
      params.require(:post).permit(:userID, :userName, :text, :threadID)
    end
  end
  