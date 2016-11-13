$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "myanimelist_client"

module Fixtures
  module Credentials
    XML = <<~EOXML
    <?xml version="1.0" encoding="utf-8"?>
    <user>
        <id>4242</id>
        <username>Oli-</username>
    </user>
    EOXML
    ID = '4242'
    USERNAME = 'Oli-'
  end

  module AnimeSearch
    XML = <<~EOXML
    <?xml version="1.0" encoding="utf-8"?>
    <anime>
      <entry>
        <id>17549</id>
        <title>Non Non Biyori</title>
        <english>Non Non Biyori</english>
        <synonyms></synonyms>
        <episodes>12</episodes>
        <score>8.05</score>
        <type>TV</type>
        <status>Finished Airing</status>
        <start_date>2013-10-08</start_date>
        <end_date>2013-12-24</end_date>
        <synopsis>Asahigaoka might look like typical, boring countryside to most; however, no day in this village can ever be considered colorless...</synopsis>
        <image>https://myanimelist.cdn-dena.com/images/anime/2/51581.jpg</image>
      </entry>
      <entry>
        <id>23623</id>
        <title>Non Non Biyori Repeat</title>
        <english>Non Non Biyori Repeat</english>
        <synonyms>Non Non Biyori 2nd Season; Non Non Biyori Second Season</synonyms>
        <episodes>12</episodes>
        <score>8.26</score>
        <type>TV</type>
        <status>Finished Airing</status>
        <start_date>2015-07-07</start_date>
        <end_date>2015-09-22</end_date>
        <synopsis>With just five students (none in the same grade ), the four girls of the tiny Asahioka Branch School still enjoy...</synopsis>
        <image>https://myanimelist.cdn-dena.com/images/anime/9/75105.jpg</image>
      </entry>
    </anime>
    EOXML

    ENTRIES = [
      MyanimelistClient::SearchEntry.new(
        id:         '17549',
        title:      'Non Non Biyori',
        english:    'Non Non Biyori',
        synonyms:   '',
        episodes:   12,
        score:      8.05,
        type:       'TV',
        status:     'Finished Airing',
        start_date: '2013-10-08',
        end_date:   '2013-12-24',
        synopsis:   'Asahigaoka might look like typical, boring countryside to most; however, no day in this village can ever be considered colorless...',
        image:      'https://myanimelist.cdn-dena.com/images/anime/2/51581.jpg'
      ),

      MyanimelistClient::SearchEntry.new(
        id:         '23623',
        title:      'Non Non Biyori Repeat',
        english:    'Non Non Biyori Repeat',
        synonyms:   'Non Non Biyori 2nd Season; Non Non Biyori Second Season',
        episodes:   12,
        score:      8.26,
        type:       'TV',
        status:     'Finished Airing',
        start_date: '2015-07-07',
        end_date:   '2015-09-22',
        synopsis:   'With just five students (none in the same grade ), the four girls of the tiny Asahioka Branch School still enjoy...',
        image:      'https://myanimelist.cdn-dena.com/images/anime/9/75105.jpg'
      )
    ]
  end

  module MangaSearch
    XML = <<~EOXML
    <?xml version="1.0" encoding="utf-8"?>
    <manga>
      <entry>
        <id>25</id>
        <title>Fullmetal Alchemist</title>
        <english>Fullmetal Alchemist</english>
        <synonyms>Full Metal Alchemist; Hagane no Renkinjutsushi; FMA; Fullmetal Alchemist Gaiden</synonyms>
        <chapters>116</chapters>
        <volumes>27</volumes>
        <score>9.14</score>
        <type>Manga</type>
        <status>Finished</status>
        <start_date>2001-07-12</start_date>
        <end_date>2010-09-11</end_date>
        <synopsis>The rules of alchemy state that to gain something, one must lose something of equal value....</synopsis>
        <image>https://myanimelist.cdn-dena.com/images/manga/1/27600.jpg</image>
      </entry>
      <entry>
        <id>4658</id>
        <title>Fullmetal Alchemist</title>
        <english>Fullmetal Alchemist</english>
        <synonyms>Hagane no Renkinjutsushi; FMA; Fullmetal Alchemist Novel</synonyms>
        <chapters>35</chapters>
        <volumes>7</volumes>
        <score>8.32</score>
        <type>Novel</type>
        <status>Finished</status>
        <start_date>2003-02-00</start_date>
        <end_date>2010-04-22</end_date>
        <synopsis>Somewhere between magic, art and science exists a world of alchemy. And into this world travel Edward and Alphonse...</synopsis>
        <image>https://myanimelist.cdn-dena.com/images/manga/3/5739.jpg</image>
      </entry>
    </manga>
    EOXML

    ENTRIES = [
      MyanimelistClient::SearchEntry.new(
        id:         '25',
        title:      'Fullmetal Alchemist',
        english:    'Fullmetal Alchemist',
        synonyms:   'Full Metal Alchemist; Hagane no Renkinjutsushi; FMA; Fullmetal Alchemist Gaiden',
        chapters:   116,
        volumes:    27,
        score:      9.14,
        type:       'Manga',
        status:     'Finished',
        start_date: '2001-07-12',
        end_date:   '2010-09-11',
        synopsis:   'The rules of alchemy state that to gain something, one must lose something of equal value....',
        image:      'https://myanimelist.cdn-dena.com/images/manga/1/27600.jpg'
      ),

      MyanimelistClient::SearchEntry.new(
        id:         '4658',
        title:      'Fullmetal Alchemist',
        english:    'Fullmetal Alchemist',
        synonyms:   'Hagane no Renkinjutsushi; FMA; Fullmetal Alchemist Novel',
        chapters:   35,
        volumes:    7,
        score:      8.32,
        type:       'Novel',
        status:     'Finished',
        start_date: '2003-02-00',
        end_date:   '2010-04-22',
        synopsis:   'Somewhere between magic, art and science exists a world of alchemy. And into this world travel Edward and Alphonse...',
        image:      'https://myanimelist.cdn-dena.com/images/manga/3/5739.jpg'
      )
    ]
  end
end
