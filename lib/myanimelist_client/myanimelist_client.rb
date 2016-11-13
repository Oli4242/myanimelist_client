# frozen_string_literal: true
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

  # Allows to search anime titles.
  # @see https://myanimelist.net/modules.php?go=api#animemangasearch The MyAnimeList's API Documentation about search.xml
  # @param [String] query    The search query.
  # @return [SearchResponse] The API response or the error message nicely wraped in an object.
  #
  def search_anime query
    search 'anime', query
  end

  # Allows to search manga titles.
  # @see https://myanimelist.net/modules.php?go=api#animemangasearch The MyAnimeList's API Documentation about search.xml
  # @param [String] query    The search query.
  # @return [SearchResponse] The API response or the error message nicely wraped in an object.
  #
  def search_manga query
    search 'manga', query
  end

  private

  # Search a manga or an anime depending on the provided type
  # @param [String] type  The search type (+'anime'+ or +'manga'+).
  # @param [String] query The search query.
  # @return [SearchResponse] The API response or the error message nicely wraped in an object.
  #
  def search type, query
    if type != 'anime' && type != 'manga'
      raise 'Invalid search type: must be anime or manga'
    end
    escaped_query = CGI::escape query
    response = RestClient::Request.execute(
      method:  :get,
      url:     "https://myanimelist.net/api/#{type}/search.xml?q=#{escaped_query}",
      user:     @username,
      password: @password
    )
    SearchResponse.new response.body
  rescue RestClient::ExceptionWithResponse => e
    SearchResponse.new e.response.body, :error
  rescue RuntimeError => e
    SearchResponse.new e.message, :error
  end
end
