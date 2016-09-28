class InterestsController < ApplicationController
  
  before_action :authenticate_user!

  # get /categories/:id/interests
  def index
    # 指定されたidのCategoryを取得
    @category = Category.find(params[:id])
    # categoryに関連付けられているinterestを取得
    @interests = @category.interests

    # interestsをjson形式でresponse
    render json: @interests
  end

  # post /categories/:id/interests
  def create

    # データベースに格納するためのデータを用意
    posted = interest_params
    posted["category_id"] = params[:id]

    # Interestインスタンスを生成
    @interest = Interest.new(posted)

    # データベースにデータを保存し、その結果をresponse変数に格納
    @response = { status: @interest.save }

    # json形式でresponse
    render json: @response
  end

  # postされるデータの受け入れ許可
  def interest_params
    params.require(:interest).permit(:name, :description)
  end 
end
