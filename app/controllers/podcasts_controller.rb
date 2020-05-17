class PodcastsController < ApplicationController

  def index
    @podcasts = Podcast.all
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)

    PodcastLoader.new(@podcast).update

    respond_to do |format|
      format.html do
        if @podcast.save
          redirect_to root_path
        else
          render :new
        end
      end
    end
  end

  private

  def podcast_params
    params.require(:podcast).permit(:url)
  end

end
