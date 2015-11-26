class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user_id = current_user.id
    @comment.save
    redirect_to :back, notice: "Your comment was successfully posted!"
  end

  def from_product
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @commentable = Product.friendly.find(params[:product_id])
    @comments = @commentable.comments.where(:campaign_id => params[:campaign_id])

    respond_to do |format|
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :campaign_id, :product_id)
    end
end
