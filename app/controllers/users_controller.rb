class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
  
    def index
      if params[:name].present?
        authenticate_user_by_name
      else
        render_all_users
      end
    end
  
    def show
      render json: @user
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        payload = { user_id: @user.id }
        token = JwtService.encode(payload)
        render json: { user: @user, token: token }, status: :created
        # render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
    
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user.destroy
      head :no_content
    end
  
    private

    def authenticate_user_by_name
      @user = User.find_by(name: params[:name])
    
      if @user
        authenticate_user_with_password
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end
    
    def authenticate_user_with_password
      if params[:password].present? && @user.password == params[:password]
        generate_token_and_render_user
      else
        render json: { error: 'Password is incorrect' }
      end
    end

    # def authenticate_user
    #   token = request.headers['Authorization']&.split(' ')&.last
    #   begin
    #     decoded_payload = JwtService.decode(token)
    #     @current_user = User.find(decoded_payload['user_id'])
    #   rescue JWT::DecodeError
    #     render json: { error: 'Invalid token' }, status: :unauthorized
    #   end
    # end
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :password)
    end
  end
  