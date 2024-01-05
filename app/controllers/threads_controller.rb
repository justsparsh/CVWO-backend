class ThreadsController < ApplicationController
    before_action :set_thread, only: [:show, :edit, :update, :destroy]
  
    def index
      @threads = Thread.all
    end
  
    def show
    end
  
    def new
      @thread = Thread.new
    end
  
    def create
      @thread = Thread.new(thread_params)
  
      if @thread.save
        redirect_to @thread, notice: 'Thread was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @thread.update(thread_params)
        redirect_to @thread, notice: 'Thread was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @thread.destroy
      redirect_to threads_url, notice: 'Thread was successfully destroyed.'
    end
  
    private
  
    def set_thread
      @thread = Thread.find(params[:id])
    end
  
    def thread_params
      params.require(:thread).permit(:userID, :userName, :text, :threadTitle)
    end
  end
  