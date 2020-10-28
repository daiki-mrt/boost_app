class SpacesController < ApplicationController
  def show
    # DM相手のユーザーを取得
    @user = User.find(params[:id])

    # user_spacesから、自分が登録されているspace_idを取得
    spaces = current_user.user_spaces.pluck(:space_id)

    # user_spacesテーブルのうち、自分とDM相手が含まれているものを取得
    tareget_user_spaces = UserSpace.find_by(space_id: spaces, user_id: @user.id)

    # すでにDMしたことがあるかどうかで、分岐
    if tareget_user_spaces.nil?
      # target_user_spacesがない => spaceを新規作成する
      @space = Space.create
      # user_spaceで自分と相手を紐付ける
      UserSpace.create(user_id: current_user.id, space_id: @space.id)
      UserSpace.create(user_id: @user.id, space_id: @space.id)
    else
      # DMをする場所(space)を取得
      @space = tareget_user_spaces.space
    end

    # spaceでのメッセージ一覧表示と投稿
    @messages = @space.messages
    @message = Message.new
  end
end
