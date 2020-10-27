class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to room_path(params[:room_id])
    else
      @room = Room.find(params[:room_id])
      @comments = Comment.includes(:user)
      render "rooms/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, room_id: params[:room_id])
  end
end
  