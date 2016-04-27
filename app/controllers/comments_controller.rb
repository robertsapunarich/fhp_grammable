class CommentsController < ApplicationController

  def create
    @gram = Gram.find_by_id(params[:gram_id])
    @gram.comments.create(comment_params.merge(user: current_user))
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

end
