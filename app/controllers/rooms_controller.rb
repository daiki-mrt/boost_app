class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :confirm_join, only: :show
  before_action :set_room, only: [:show, :edit, :update, :join, :confirm_join]

  def index
    @rooms = Room.includes(:users).order("created_at DESC")
    @users = User.all
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
    set_room
    @comments = @room.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    set_room
  end

  def update
    set_room
    if @room.valid?
      @room.update(room_params)
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  def destroy
    set_room
    if @room.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  # ルーム入室確認ビュー
  def confirm
  end

  # 参加ボタンでルームにユーザーを登録
  def join
    set_room
    @room.users << current_user
    @room.save
    redirect_to room_path(@room)
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end


  def room_params
    params.require(:room).permit(:name, :text).merge(user_ids: current_user.id)
  end

  def confirm_join
    set_room
    unless @room.users.include?(current_user)
      render :confirm
    end
  end
end
