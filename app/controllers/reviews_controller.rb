class ReviewsController < ApplicationController
  before_action :authenticated_user!, except: %i[index show]
  before_action :find_idea, only: %i[create destroy]
  before_action :find_review, only: [:destroy]

  def create
    @review = Review.new review_params
    @review.idea = @idea
    if @review.save
      flash[:success] = "Review created succefffully!"
      redirect_to idea_path(@idea)
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      render "/ideas/show", status: 303
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "Review Deleted!"
    redirect_to idea_path(@idea)
  end

  private

  def find_idea
    @idea = Idea.find(params[:idea_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :body)
  end

end
