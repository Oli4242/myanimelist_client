# This class is used to reprensent an entry within a {SearchResponse}. It can describe either an anime or a manga.
#
# @example
#   require 'myanimelist_client'
#
#   client = MyanimelistClient.new 'username', 'password'
#
#   client.search_anime('anime name').each do |entry|
#     # entry is a SearchResponse.
#
#     # It exposes all its attributes:
#     entry.id                # => String or nil
#     entry.title             # => String or nil
#     entry.english           # => String or nil
#     entry.synonyms          # => String or nil
#     entry.episodes          # => Fixnum or nil
#     entry.chapters          # => Fixnum or nil
#     entry.volumes           # => Fixnum or nil
#     entry.score             # => Float or nil
#     entry.type              # => String or nil
#     entry.status            # => String or nil
#     entry.start_date        # => String or nil
#     entry.end_date          # => String or nil
#     entry.synopsis          # => String or nil
#     entry.image             # => String or nil
#
#     # It provides some useful predicates:
#     entry.manga?            # => true or false
#     entry.anime?            # => true or false
#     entry.upcoming?         # => true or false
#     entry.ongoing?          # => true or false
#     entry.finished?         # => true or false
#
#     # It can be converted to a hash:
#     entry.to_h              # => Hash
#   end
#
# @attr [String, nil] id         Returns the ID.
# @attr [String, nil] title      Returns the title.
# @attr [String, nil] english    Returns the english title.
# @attr [String, nil] synonyms   Returns the synonyms.
# @attr [Fixnum, nil] episodes   Returns the number of episodes (+nil+ when the entry describes a manga).
# @attr [Fixnum, nil] chapters   Returns the number of chapters (+nil+ when the entry describes an anime).
# @attr [Fixnum, nil] volumes    Returns the number of volumes (+nil+ when the entry describes an anime).
# @attr [Float, nil]  score      Returns the score.
# @attr [String, nil] type       Returns the type.
# @attr [String, nil] status     Returns the status.
# @attr [String, nil] start_date Returns the start date.
# @attr [String, nil] end_date   Returns the end date.
# @attr [String, nil] synopsis   Returns the synopsis.
# @attr [String, nil] image      Returns the image's URL.
#
class MyanimelistClient::SearchEntry

  # The list of attributes defining the entry for internal usage.
  ATTRIBUTES = %w(
    id
    title
    english
    synonyms
    episodes
    chapters
    volumes
    score
    type
    status
    start_date
    end_date
    synopsis
    image
  )

  # attr_reader *ATTRIBUTES      # this line cause a warning in yard
  send :attr_reader, *ATTRIBUTES # this line doesn't... :/

  # @param [Hash] options  A hash used to hydrate the object.
  def initialize options={}
    ATTRIBUTES.each do |attribute|
      instance_variable_set "@#{attribute}", options[attribute] || options[attribute.to_sym]
    end
  end

  # Creates a hash representing the entry.
  # @return [Hash]
  def to_h
    values = ATTRIBUTES.map{|attribute| send attribute }
    Hash[ATTRIBUTES.zip values]
  end

  # Performs a loose equality based on the value of the attributes (see {ATTRIBUTES}).
  def == other
    ATTRIBUTES.each do |attribute|
      if !other.respond_to?(attribute) || send(attribute) != other.send(attribute)
        return false
      end
    end
    true
  end

  # Returns +true+ when the entry describes an anime.
  def anime?
    !!@episodes
  end

  # Returns +true+ when the entry describes a manga.
  def manga?
    !!(@chapters && @volumes)
  end

  # Returns +true+ when the anime is not yet aired / when the manga is not yet published.
  def upcoming?
    !!(/not\s+yet/i =~ @status)
  end

  # Returns +true+ when the anime is currently airing / when the manga is currently publishing.
  def ongoing?
    !!(/currently|publishing/i =~ @status)
  end

  # Returns +true+ when the anime or manga is finished.
  def finished?
    !!(/finished/i =~ @status)
  end
end
