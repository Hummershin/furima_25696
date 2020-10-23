class CommentsChannel < ApplicationCable::Channel
  def subscribed
    @item = Item.find(params[:item_id]) # 変更
    stream_for @item                    # 変更 stream_fromではなくstream_for
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end