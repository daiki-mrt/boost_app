class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @rooms = Room.includes(:users).order("created_at DESC")
  end

  def new
    @room = Room.new()
  end

  def create
    @room = Room.new(room_params)
    if @room.valid?
      @room.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @comments = Comment.includes(:user)
    @comment = Comment.new
  end

  # 参加ボタンでルームにユーザーを登録
  def join
    @room = Room.find(params[:id])
    @room.users << current_user
    @room.save
    redirect_to room_path(@room)
  end

  private
  def room_params
    params.require(:room).permit(:name, :text).merge(user_ids: current_user.id)
  end
end
