require 'rspotify'

class Spotify
  def playlists
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

    play_lists = RSpotify::Playlist.search('アニソン')
    play_list = play_lists.sample

    return play_list.external_urls['spotify']
  end
end
