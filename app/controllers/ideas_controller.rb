class IdeasController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      flash[:success] = "Idea created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @idea.destroy
    flash[:success] = "Idea deleted"
    redirect_to request.referrer || root_url
  end

  def index
    @idea  = current_user.ideas.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def new
    @idea = Idea.new
  end

  def show
    @idea = Idea.find(params[:id])
  end

  private

    def idea_params
      params.require(:idea).permit(:title, :content, :picture)
    end

    def correct_user
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to root_url if @idea.nil?
    end
end
