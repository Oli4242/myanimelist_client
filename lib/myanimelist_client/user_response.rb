# This class represents a User. It is returned by {#verify_credentials}.
#
# +UserResponse+ is responsible for parsing and wraping the XML (or any error message) from the API.
#
# @example
#   require 'myanimelist_client'
#
#   client = MyanimelistClient.new 'username', 'password'
#
#   user = client.verify_credentials
#                         # => UserResponse
#
#   # It provides two predicates to handle login errors:
#   user.error?           # => true or false
#   user.ok?              # => true or false
#
#   # On error, user.raw may contain an error message:
#   if user.error?
#     user.raw            # => String or nil
#   end
#
#   # On success you can access to user's attributes:
#   if user.ok?
#     user.id             # => String or nil
#     user.username       # => String or nil
#   end
#
# @attr [String, nil] raw      Returns the raw response from the API. Or the raw error message.
# @attr [String, nil] id       Return the MyAnimeList ID of the current account.
# @attr [String, nil] username Returns the MyAnimeList username of the current account.
#
class MyanimelistClient::UserResponse
  attr_reader :raw, :id, :username

  # @param [String, nil] raw_xml  The raw response from the API or an error message (or even +nil+).
  def initialize raw_xml
    @raw       = raw_xml

    parsed_xml = Nokogiri::XML raw_xml
    @id        = parsed_xml.at_css('id')&.content
    @username  = parsed_xml.at_css('username')&.content
  end

  # Returns +true+ if an error occured.
  def error?
    @raw.nil? || @id.nil? || @username.nil?
  end

  # Returns +true+ if no error occured.
  def ok?
    not error?
  end
end
