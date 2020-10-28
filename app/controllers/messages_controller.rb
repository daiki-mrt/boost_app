class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save
      redirect_to request.referer
    else
      render action: "spaces/show"
    end
  end

  private
  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, space_id: params[:space_id])
  end
end
