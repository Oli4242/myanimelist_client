# frozen_string_literal: true
require 'spec_helper'

describe MyanimelistClient::SearchEntry do
  %i(
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
  ).each do |property|
    it "accepts ##{property}" do
      entry = MyanimelistClient::SearchEntry.new property => 'foobar'
      expect(entry.send property).to eq 'foobar'
    end
  end

  it 'is convertible to hash' do
    hash = {
      'id'         => 'toto',
      'title'      => 'tata',
      'english'    => 'titi',
      'synonyms'   => 'tutu',
      'episodes'   => 'tete',
      'chapters'   => 'tyty',
      'volumes'    => 'blabla',
      'score'      => 'blibli',
      'type'       => 'bloblo',
      'status'     => 'bleble',
      'start_date' => 'blublu',
      'end_date'   => 'blybly',
      'synopsis'   => 'foobar',
      'image'      => 'foobarbaz'
    }
    entry = MyanimelistClient::SearchEntry.new hash
    expect(entry.to_h).to eq hash
  end

  it 'is comparable with ==' do
    options = { id: '0', title: 'toto', episodes: 0 }
    entry1  = MyanimelistClient::SearchEntry.new options
    entry2  = MyanimelistClient::SearchEntry.new options
    expect(entry1).to eq entry2
  end

  context 'as an anime' do
    let :anime do
      MyanimelistClient::SearchEntry.new episodes: 12, chapters: 0, volumes: 0
    end

    it 'is an anime' do
      expect(anime.anime?).to eq true
    end

    it 'is not a manga' do
      expect(anime.manga?).to eq false
    end
  end

  context 'as a manga' do
    let :manga do
      MyanimelistClient::SearchEntry.new chapters: 22, volumes: 3, episodes: 0
    end

    it 'is a manga' do
      expect(manga.manga?).to eq true
    end

    it 'is not an anime' do
      expect(manga.anime?).to eq false
    end
  end

  describe 'about its status:' do
    it 'knows when it is currently airing' do
      currently_airing = MyanimelistClient::SearchEntry.new status: 'Currently Airing'
      expect(currently_airing.upcoming?).to eq false
      expect(currently_airing.ongoing?).to eq true
      expect(currently_airing.finished?).to eq false
    end

    it 'knows when it is currently publishing' do
      currently_publishing = MyanimelistClient::SearchEntry.new status: 'Publishing'
      expect(currently_publishing.upcoming?).to eq false
      expect(currently_publishing.ongoing?).to eq true
      expect(currently_publishing.finished?).to eq false
    end

    it 'knows when it is finished' do
      finished = MyanimelistClient::SearchEntry.new status: 'Finished'
      expect(finished.upcoming?).to eq false
      expect(finished.ongoing?).to eq false
      expect(finished.finished?).to eq true
    end

    it 'knows when it is not yet aired' do
      not_yet_aired = MyanimelistClient::SearchEntry.new status: 'Not yet aired'
      expect(not_yet_aired.upcoming?).to eq true
      expect(not_yet_aired.ongoing?).to eq false
      expect(not_yet_aired.finished?).to eq false
    end

    it 'knows when it is not yet published' do
      not_yet_published = MyanimelistClient::SearchEntry.new status: 'Not yet published'
      expect(not_yet_published.upcoming?).to eq true
      expect(not_yet_published.ongoing?).to eq false
      expect(not_yet_published.finished?).to eq false
    end
  end
end
