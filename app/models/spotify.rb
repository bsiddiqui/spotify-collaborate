require 'json'
require 'net/http'

module Spotify

  def call(song_name)
    @@song_name = to_url(song_name)
    get_songs
  end

  private

  def get_songs
    json_response["tracks"].map {|track| [track["name"], track["href"], track["artists"].first["name"]]}
  end

  def json_response
    JSON.parse(get_response.body)
  end

  def get_response
    Net::HTTP.get_response(build_uri)
  end

  def build_uri
    URI("http://ws.spotify.com/search/1/track.json?q=#{@@song_name}")
  end

  def to_url(song_name)
    song_name.split(" ").join("+")
  end

end

