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

  end

  def new

  end

  private

    def idea_params
      params.require(:idea).permit(:content, :picture)
    end

    def correct_user
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to root_url if @idea.nil?
    end
end
