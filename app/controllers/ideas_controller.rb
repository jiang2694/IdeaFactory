class IdeasController < ApplicationController
  before_action :authenticated_user!, except: %i[index show]
  before_action :find_idea, only: %i[edit update show destroy]
  before_action :authorized_user!, only: %i[edit update destroy]

  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.all.order(updated_at: :desc)
  end

  def show
    @reviews = @idea.reviews.order(updated_at: :desc)
    @review = Review.new
  end

  def edit
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = @current_user
    if @idea.save
      redirect_to ideas_path(@idea)
    else 
      render :new
    end
  end

  def update
    if @idea.update(idea_params)
      flash[:success] = "Idea updated!"
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    if @idea.destroy
      flash[:success] = "Idea deleted!"
      redirect_to ideas_path
    else
      flash[:danger] = "Can't delete"
    end
  end

  private

  def find_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def authorized_user!
    unless can?(:crud, @idea)
      flash[:danger] = "You don't have permission"
      redirect_to root_path
    end
  end

end
