class CommentsController < ApplicationController
  def create
    @asset = Asset.find(params[:asset_id])
    @user_who_commented = current_user
    comment = Comment.build_from( @asset, @user_who_commented.id, params[:comment][:body] )
    comment.save!
    track_activity @asset
    redirect_to asset_path(@asset)
  end
end
