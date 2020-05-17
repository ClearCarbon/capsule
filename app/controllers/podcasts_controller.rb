class PodcastsController < ApplicationController

  def index
    @podcasts = Podcast.all
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)

    uri = URI(@podcast.url)
    rss = Net::HTTP.get(uri)
    feed = RSS::Parser.parse(rss)
    puts "Title: #{feed.channel.title}"
    feed.items.each do |item|
      puts "Item: #{item.title}"
    end

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
