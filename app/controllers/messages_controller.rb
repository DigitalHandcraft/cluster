class MessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @channel = Channel.find(params[:id])
    @messages = @channel.messages

    render json: @messages
  end

  def create
    posted = message_params
    # posted["user_id"] = req.session.id
    posted["user_id"] = 1
    posted["channel_id"] = params[:id]

    @message = Message.new(posted)
    @response = { status: @message.save }

    render json: @response
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
