class ThreadsController < ApplicationController
  before_action :set_thread, only: [:show, :update, :destroy]
  before_action :set_user, only: [:count, :index]

  def index
    page_number = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = 5 

    ticker_params = JSON.parse(params[:tickers])
    sentiment_params = JSON.parse(params[:sentiments])

    if @user 
      @threads = @user.message_threads.order(id: :desc).offset((page_number - 1) * per_page).limit(per_page)
    else 
      @threads = MessageThread.order(id: :desc).offset((page_number - 1) * per_page).limit(per_page)
    end

    if ticker_params.length > 0
      @threads = @threads.tagged_with(ticker_params, :any => true)
    end

    if sentiment_params.length > 0
      @threads = @threads.tagged_with(sentiment_params, :any => true)
    end

    render json: @threads
  end

  def show
    render json: [@thread]
  end

  def create
    @thread = MessageThread.new(thread_params)

    if @thread.save
      render json: @thread, status: :created
    else
      render json: @thread.errors, status: :unprocessable_entity
    end
  end

  def update
    if @thread.update(thread_params)
      render json: @thread, status: :ok
    else
      render json: @thread.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @thread.destroy
    render json: { message: 'Thread was successfully destroyed.' }, status: :ok
  end

  def count
    if @user 
      total_threads = @user.message_threads.count
    else
      total_threads = MessageThread.count
    end
    render json: { total_threads: total_threads }
  end

  private

  def set_user
    @user = User.find_by(id: params[:userID])
  end

  def set_thread
    @thread = MessageThread.find(params[:id])
  end

  def thread_params
    params.require(:thread).permit(:userID, :userName, :text, :threadTitle, :ticker_list, :sentiment_list)
  end
end

  