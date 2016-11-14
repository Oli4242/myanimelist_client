# MyAnimeList Client
[![Gem Version](https://badge.fury.io/rb/myanimelist_client.svg)](https://badge.fury.io/rb/myanimelist_client)
[![Code Climate](https://codeclimate.com/github/Oli4242/myanimelist_client/badges/gpa.svg)](https://codeclimate.com/github/Oli4242/myanimelist_client)

A gem for the [MyAnimeList.net API](https://myanimelist.net/modules.php?go=api).

For now you can:

* [Search anime](https://myanimelist.net/modules.php?go=api#animemangasearch)
* [Search manga](https://myanimelist.net/modules.php?go=api#animemangasearch)
* [Verify credentials](https://myanimelist.net/modules.php?go=api#verifycred)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'myanimelist_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install myanimelist_client

## Overview
```ruby
require 'myanimelist_client'

# First, create a client
# MyAnimeList.net requires a valid account to consume their API
client = MyanimelistClient.new 'username', 'password'

# Then you may want to check if your username / password are ok
if client.verify_credentials.ok?

  # Now you can use the API
  # Let's search a good anime!
  results = client.search_anime 'K-On'

  # Everything is nicely wrapped in small objects
  results.sort_by(&:score).reverse!.each do |anime|
    puts "#{anime.title} (#{anime.english}) - #{anime.score}"
  end

end
```

Nice, isn't it?

## Usage

### The Client
The client memorizes your username and password (myanimelist.net requires a valid account in order to consume their API) then it allows you to use the API:

```ruby
client = MyanimelistClient.new('username', 'password')
```

### Verify Credentials
Check your username / password with `#verify_credentials`:

```ruby
user = client.verify_credentials # => MyanimelistClient::UserResponse

user.ok?                         # true when everything went right
user.error?                      # true when an error occured
user.raw                         # the raw response from the API or the error message
```

### Search Anime
Search anime with `#search_anime`:

```ruby
results = client.search_anime('anime name')
                          # => MyanimelistClient::SearchResponse

# It includes Ruby's Enumerable module:
results.each do |anime|
  anime.id                # => String or nil
  anime.title             # => String or nil
  anime.english           # => String or nil
  anime.synonyms          # => String or nil
  anime.episodes          # => Fixnum or nil
  anime.score             # => Float or nil
  anime.type              # => String or nil
  anime.status            # => String or nil
  anime.start_date        # => String or nil
  anime.end_date          # => String or nil
  anime.synopsis          # => String or nil
  anime.image             # => String or nil

  anime.manga?            # => false
  anime.anime?            # => true
  anime.upcoming?         # => true when the anime is not yet aired
  anime.ongoing?          # => true when the anime is currently airing
  anime.finished?         # => true when the anime is finished

  anime.ok?               # when no error occured
  anime.error?            # when an error occured
  anime.raw               # => String containing the raw response from the API or the error message
  anime.to_h              # => Hash
end

results.length            # => Fixnum
results.empty?            # => true or false
results.to_a              # => Array
results[0]                # => MyanimelistClient::SearchEntry or nil
```

### Search Manga
Search manga with `#search_manga`:

```ruby
results = client.search_manga('anime name')
                          # => MyanimelistClient::SearchResponse

# It includes Ruby's Enumerable module:
results.each do |manga|
  manga.id                # => String or nil
  manga.title             # => String or nil
  manga.english           # => String or nil
  manga.synonyms          # => String or nil
  manga.chapters          # => Fixnum or nil
  manga.volumes           # => Fixnum or nil
  manga.score             # => Float or nil
  manga.type              # => String or nil
  manga.status            # => String or nil
  manga.start_date        # => String or nil
  manga.end_date          # => String or nil
  manga.synopsis          # => String or nil
  manga.image             # => String or nil

  manga.manga?            # => true
  manga.anime?            # => false
  manga.upcoming?         # => true when the manga is not yet published
  manga.ongoing?          # => true when the manga is currently publishing
  manga.finished?         # => true when the manga is finished

  manga.ok?               # when no error occured
  manga.error?            # when an error occured
  manga.raw               # => String containing the raw response from the API or the error message
  manga.to_h              # => Hash
end

results.length            # => Fixnum
results.empty?            # => true or false
results.to_a              # => Array
results[0]                # => MyanimelistClient::SearchEntry or nil
```

## API Documentation
[The API documentation at rubydoc.info](http://www.rubydoc.info/github/Oli4242/myanimelist_client/master)

## Contributing
[Report issues here](https://github.com/Oli4242/myanimelist_client/issues).

To make a pull request:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write specs and test your code (`rake spec`)
4. Try not to offend RuboCop (`rake rubocop`)
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

## Thanks
Thanks to [harveyico](https://github.com/harveyico) for his [myanimelist gem](https://github.com/harveyico/myanimelist), it helped me (I was using it before and its code kinda influenced me).

Of course, thanks to the myanimelist.net team for their work.

## License MIT
> The MIT License (MIT)
>
> Copyright (c) 2016 Oli4242
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.
