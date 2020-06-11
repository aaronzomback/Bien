class CommentsController < ApplicationController


  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.new(params.require(:comment).permit(:body))

    # associate the comment with the current user before saving
    @comment.user = @current_user
    @comment.save

    # go back to our review show page
    redirect_to review_path(@review)
end

end
