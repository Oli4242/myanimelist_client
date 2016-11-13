# frozen_string_literal: true
require 'spec_helper'

describe MyanimelistClient::UserResponse do
  context 'with a valid XML response' do
    let :user do
      MyanimelistClient::UserResponse.new Fixtures::Credentials::XML
    end

    it 'gives the raw response' do
      expect(user.raw).to eq Fixtures::Credentials::XML
    end

    it 'gives the user id' do
      expect(user.id).to eq Fixtures::Credentials::ID
    end

    it 'gives the username' do
      expect(user.username).to eq Fixtures::Credentials::USERNAME
    end

    it 'is not erroneous' do
      expect(user.error?).to eq false
    end

    it 'is ok' do
      expect(user.ok?).to eq true
    end
  end

  context 'with an invalid response' do
    let :invalid_response do
      'invalid'
    end

    let :invalid_user do
      MyanimelistClient::UserResponse.new invalid_response
    end

    it 'gives the raw response anyway' do
      expect(invalid_user.raw).to eq invalid_response
    end

    it 'is erroneous' do
      expect(invalid_user.error?).to eq true
    end

    it 'is not ok' do
      expect(invalid_user.ok?).to eq false
    end
  end
end
