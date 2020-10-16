class CommentsController < ApplicationController
  def create
    @item Item.find(params[:item_id])
    @comment = Comment.new(comment_params)

    if @comment.save
      ActionCable.server.broadcast "connect_slack_channel", {content: @comment.content, user_name: @comment.user.nickname}
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
      .merge(user_id: current_user.id)
      .merge(item_id: @item.id)
  end
end
