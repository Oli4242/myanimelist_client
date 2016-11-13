# frozen_string_literal: true
require 'spec_helper'

describe MyanimelistClient::SearchResponse do
  it 'is convertible to array' do
    expect(MyanimelistClient::SearchResponse.new '').to respond_to :to_a
  end

  it 'is enumerable' do
    expect(MyanimelistClient::SearchResponse.new '').to be_an Enumerable
  end

  context 'with a valid XML response (anime)' do
    let :animes do
      MyanimelistClient::SearchResponse.new Fixtures::AnimeSearch::XML
    end

    it 'gives the raw response' do
      expect(animes.raw).to eq Fixtures::AnimeSearch::XML
    end

    it 'has the right length' do
      expect(animes.length).to eq 2
    end

    it 'is browsable using brackets []' do
      expect(animes[1]).to eq Fixtures::AnimeSearch::ENTRIES[1]
    end

    it 'has the right values' do
      expect(animes.to_a).to eq Fixtures::AnimeSearch::ENTRIES
    end

    it 'is not erroneous' do
      expect(animes.error?).to eq false
    end

    it 'is ok' do
      expect(animes.ok?).to eq true
    end
  end

  context 'with a valid XML response (manga)' do
    let :mangas do
      MyanimelistClient::SearchResponse.new Fixtures::MangaSearch::XML
    end

    it 'gives the raw response' do
      expect(mangas.raw).to eq Fixtures::MangaSearch::XML
    end

    it 'has the right length' do
      expect(mangas.length).to eq 2
    end

    it 'is browsable using brackets []' do
      expect(mangas[1]).to eq Fixtures::MangaSearch::ENTRIES[1]
    end

    it 'has the right values' do
      expect(mangas.to_a).to eq Fixtures::MangaSearch::ENTRIES
    end

    it 'is not erroneous' do
      expect(mangas.error?).to eq false
    end

    it 'is ok' do
      expect(mangas.ok?).to eq true
    end
  end

  context 'with an invalid response' do
    let :erroneous_response do
      MyanimelistClient::SearchResponse.new 'erroneous', true
    end

    it 'still gives the raw response' do
      expect(erroneous_response.raw).to eq 'erroneous'
    end

    it 'is erroneous' do
      expect(erroneous_response.error?).to eq true
    end

    it 'is not ok' do
      expect(erroneous_response.ok?).to eq false
    end
  end
end
