class Products::CommentsController < CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = Product.friendly.find(params[:product_id])
    end
end
