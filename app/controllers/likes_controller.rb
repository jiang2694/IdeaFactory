class LikesController < ApplicationController

  before_action :authenticated_user!, only: %i[create destroy]

  def create
    @idea = Idea.find params[:idea_id]
    @like = Like.new( user: current_user, idea: @idea )
      if @like.save
        flash[:success] = "Idea liked"
        redirect_to ideas_path(@idea)
      else
        flash[:alert] = @like.errors.full_messages.join(', ')
        redirect_to root_path
      end
  end

  def destroy
    like = Like.find params[:id]
    if can?(:destroy, like)
      like.destroy
      flash[:notice] = "Idea unliked"
      redirect_to ideas_path
    else
      flash[:alert] = like.errors.full_messages.join(', ')
      redirect_to ideas_path
    end
  end
end

