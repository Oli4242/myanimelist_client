# This is the main class. It represents a client that can consume the {https://myanimelist.net/modules.php?go=api MyAnimeList.net API}.
#
# It allows to search for anime and manga titles as well as verify your username / password.
#
# @example
#   require 'myanimelist_client'
#
#   # MyAnimeList requires a valid account in order to consume their API:
#   client = MyanimelistClient.new 'username', 'password'
#
#   # Verify credentials:
#   user = client.verify_credentials           # => UserResponse
#
#   if user.error?
#     STDERR.puts "An error occured: #{user.raw}"
#     exit
#   end
#
#   # Search anime:
#   results = client.search_anime 'anime name' # => SearchResponse
#
#   puts 'Error...'         if results.error?
#   puts 'Found nothing...' if results.ok? && results.empty?
#
#   results.sort_by(:score).reverse!.each do |anime|
#     puts "#{anime.title} - #{anime.score}"
#   end
#
#   # Search manga:
#   results = client.search_manga 'manga name' # => SearchResponse
#
#   results.select{ |manga| manga.volumes < 10 }.each do |manga|
#     puts "#{manga.title} - #{manga.english}"
#   end
#
# @attr [String] username  Returns the username
# @attr [String] password  Returns the password
#
class MyanimelistClient
  attr_accessor :username, :password

  # @param [String] username  A valid myanimelist username
  # @param [String] password  A valid myanimelist password
  #
  def initialize username, password
    @username = username
    @password = password
  end

  # Allows to check username/password.
  # @see https://myanimelist.net/modules.php?go=api#verifycred The MyAnimeList's API Documentation about verify_credentials.xml
  # @return [UserResponse] The API response or the error message nicely wraped in an object.
  #
  def verify_credentials
    begin
      response = RestClient::Request.execute(
        method:  :get,
        url:     'https://myanimelist.net/api/account/verify_credentials.xml',
        user:     @username,
        password: @password
      )
      UserResponse.new response.body
    rescue RestClient::ExceptionWithResponse => e
      UserResponse.new e.response.body
    end
  end

  # Allows to search anime titles.
  # @see https://myanimelist.net/modules.php?go=api#animemangasearch The MyAnimeList's API Documentation about search.xml
  # @param [String] query    The search query.
  # @return [SearchResponse] The API response or the error message nicely wraped in an object.
  #
  def search_anime query
    begin
      escaped_query = CGI::escape query
      response = RestClient::Request.execute(
        method:  :get,
        url:     "https://myanimelist.net/api/anime/search.xml?q=#{escaped_query}",
        user:     @username,
        password: @password
      )
      SearchResponse.new response.body
    rescue RestClient::ExceptionWithResponse => e
      SearchResponse.new e.response.body, :error
    end
  end

  # Allows to search manga titles.
  # @see https://myanimelist.net/modules.php?go=api#animemangasearch The MyAnimeList's API Documentation about search.xml
  # @param [String] query    The search query.
  # @return [SearchResponse] The API response or the error message nicely wraped in an object.
  #
  def search_manga query
    begin
      escaped_query = CGI::escape query
      response = RestClient::Request.execute(
        method:  :get,
        url:     "https://myanimelist.net/api/manga/search.xml?q=#{escaped_query}",
        user:     @username,
        password: @password
      )
      SearchResponse.new response.body
    rescue RestClient::ExceptionWithResponse => e
      SearchResponse.new e.response.body, :error
    end
  end
end
