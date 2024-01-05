class ThreadsController < ApplicationController
  before_action :set_thread, only: [:show, :update, :destroy]

  def index
    @threads = MessageThread.all
    render json: @threads
  end

  def show
    render json: @thread
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
    total_threads = MessageThread.count
    render json: { total_threads: total_threads }
  end

  private

  def set_thread
    @thread = MessageThread.find(params[:id])
  end

  def thread_params
    params.require(:thread).permit(:userID, :userName, :text, :threadTitle)
  end
end

  