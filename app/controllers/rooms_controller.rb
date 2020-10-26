class RoomsController < ApplicationController
  def index
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
  

  private
  def room_params
    params.require(:room).permit(:name, :text).merge(user_ids: current_user.id)
  end
end
