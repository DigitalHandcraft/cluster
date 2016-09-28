class ChannelsController < ApplicationController
  
  before_action :authenticate_user!

  def ind
    @channels = Channel.all()
    render json: @channels
  end

  def index 
    # urlに付加されているinterest_idを使用してinterestsテーブルからデータを取得し, 
    @interests = Interest.find(params[:id])
    # interestsとassociationで関連付けられているchannelsを取得する
    @channels = @interests.channels

    render json: @channels
  end

  def create
    posted = channel_params
    # posted["user_id"] = req.session.id
    posted["user_id"] = 1
    posted["interest_id"] = params[:id]

    @channel = Channel.new(posted)

    @response = {status: @channel.save}

    render json:@response
  end

  def channel_params
    params.require(:channel).permit(:name)
  end

end
