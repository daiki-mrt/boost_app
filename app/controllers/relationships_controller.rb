class RelationshipsController < ApplicationController
  # Relationshipsにフォローするユーザー(current)とフォローされるユーザー(follower)のidを保存
  def create
    follow = current_user.active_relationships.new(follower_id: params[:user_id])
    follow.save
    redirect_to user_path(params[:user_id])
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to user_path(params[:user_id])
  end
end
