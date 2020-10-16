class CommentsChannel < ApplicationCable::Channel
  def subscribed
     stream_from "connect_slack_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
