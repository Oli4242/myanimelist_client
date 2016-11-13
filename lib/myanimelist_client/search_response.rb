# This class represents a response to a search request. It is returned by {#search_anime} and {#search_manga}.
#
# +SearchResponse+ is responsible for parsing and wraping the XML response from the myanimelist API (or the error message).
#
# It wraps every entry in a {SearchEntry} instance and it includes the Ruby's +Enumerable+ module so it is easy to iterate over, sort it, etc.
#
# @example
#   require 'myanimelist_client'
#
#   client = MyanimelistClient.new 'username', 'password'
#
#   results = client.search_anime 'anime name'
#                         # => SearchResponse
#
#   # It provides two predicates for error handling:
#   results.ok?           # => true or false
#   results.error?        # => true or false
#
#   # On error, results.raw may contain an error message:
#   if results.error?
#     results.raw         # => String or nil
#   end
#
#   # On success you can browse the results:
#   if results.ok?
#     # It provides basic informations:
#     results.length      # => Fixnum
#     results.empty?      # => true or false
#
#     # It is browsable more or less like an Array would be:
#     results.first == results[0]
#                         # => true
#
#     # It is enumerable so you can use #each, #map, #sort_by, #select, etc.
#     # An exemple:
#     top3 = results.sort_by(&:score).reverse!.take(3).to_a
#     top3.each_with_index do |entry, index|
#       puts "#{index+1}. #{entry.title} - #{entry.score}"
#     end
#
#     # Yes, it is awesome ! :3
#
#   end
#
# @attr [String, nil] raw  Returns the raw response from the API or the error message.
#
class MyanimelistClient::SearchResponse
  include Enumerable
  attr_reader :raw

  # @param [String, nil] raw_xml The raw XML response from the API or an error message.
  # @param [String, nil] error   The error flag, set it to true if an error occured.
  def initialize raw_xml, error=false
    @raw       = raw_xml
    @error     = !!error
    @entries   = []

    parsed_xml = Nokogiri::XML raw_xml
    animes     = parsed_xml.css 'anime entry'
    mangas     = parsed_xml.css 'manga entry'

    (animes + mangas).each do |entry|
      @entries.push MyanimelistClient::SearchEntry.new(
        id:         entry.at_css('id')&.content,
        title:      entry.at_css('title')&.content,
        english:    entry.at_css('english')&.content,
        synonyms:   entry.at_css('synonyms')&.content,
        episodes:   entry.at_css('episodes')&.content&.to_i,
        chapters:   entry.at_css('chapters')&.content&.to_i,
        volumes:    entry.at_css('volumes')&.content&.to_i,
        score:      entry.at_css('score')&.content&.to_f,
        type:       entry.at_css('type')&.content,
        status:     entry.at_css('status')&.content,
        start_date: entry.at_css('start_date')&.content,
        end_date:   entry.at_css('end_date')&.content,
        synopsis:   entry.at_css('synopsis')&.content,
        image:      entry.at_css('image')&.content
      )
    end
  end

  # Similar to +Array+'s +#each+.
  # @return [self, Enumerator]
  def each &block
    if block_given?
      @entries.each &block
      self
    else
      @entries.each
    end
  end

  # Returns the number of entries returned by the search request.
  # @return [Fixnum] The number of entries (either animes or mangas) in the search response.
  def length
    @entries.size
  end

  alias_method :size, :length

  # Is it empty?
  def empty?
    @entries.empty?
  end

  # Allows to browse the entries like with an array.
  # @param [Fixnum] index  The index of the desired entry.
  # @return [SearchEntry, nil]
  def [] index
    @entries[index]
  end

  # Returns +true+ if an error occured.
  def error?
    @error
  end

  # Returns +true+ if no error occured.
  def ok?
    not error?
  end
end
