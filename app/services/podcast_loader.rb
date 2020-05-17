class PodcastLoader

  def initialize(podcast)
    @podcast = podcast
  end

  def update
    rss = get_rss_text(@podcast.url)
    feed = RSS::Parser.parse(rss)

    @podcast.title = feed.channel.title
    @podcast.description = feed.channel.description
    @podcast.language = feed.channel.language
    @podcast.subtitle = feed.channel.itunes_subtitle
    @podcast.author = feed.channel.itunes_author
    @podcast.image_url = feed.channel.image.url
    @podcast.category = feed.channel.itunes_category
    @podcast.owner_name = feed.channel.itunes_owner
  end

  private

  def get_rss_text(url, request_count: 1)
    uri = URI(url)
    rss_response = Net::HTTP.get_response(uri)
    
    if rss_response.code.in? ['302', '301']
      if request_count < 10
        get_rss_text(rss_response['location'], request_count: request_count + 1)
      else
        raise 'Maximum redirect follow reached'
      end
    elsif rss_response.code == '200'
      return rss_response.body
    else
      raise "An error occured when trying to access the RSS Feed #{rss_response.code} - #{rss_response.message}"
    end
  end

end