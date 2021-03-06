require 'rails_helper'

RSpec.describe 'Team API', type: :request do
  let!(:teams) {create_list(:team, 10)}

  describe "POST /teams (Create team)" do

    before do
      post '/teams', params: {team: {:rank => 01, :name => 'Real Madrid', :league =>'Liga BBVA'}}
    end

    it 'should create a new team' do
      get '/teams/11'

      json = JSON.parse(response.body)
      expect(json['name']).to eq('Real Madrid')

      get '/teams'

      json = JSON.parse(response.body)
      expect(json.size).to eq(11)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  describe "GET /teams (Show all teams)" do

    before do
      get '/teams'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns teams' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end

  describe "GET /teams/:id (Show a particular team)" do

    before do
      get '/teams/1'
    end

    it 'should return 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'should return a team by id 1 ' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json['id']).to eq(1)
      expect(json['name']).not_to be_empty
    end
  end

  describe "DELETE /teams/:id (Delete a team)" do

    before do
      delete '/teams/1'
      delete '/teams/2'
    end

    it 'should return 204 status code' do
      expect(response).to have_http_status(204)
    end

    it 'should have 8 teams remaining' do
      get '/teams'
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(8)
    end
  end

  describe "PUT /teams/:id (Update a team)" do

    before do
      put '/teams/1', params: {team: {:rank => 01, :name => 'Raimon Eleven', :league =>'Japan'}}
    end

    it 'should return 204 status code' do
      expect(response).to have_http_status(200)
    end

    it 'should update team with id 1' do
      get '/teams/1'
      json = JSON.parse(response.body)
      expect(json['name']).to eq('Raimon Eleven')
      expect(json['league']).to eq('Japan')
    end

    it 'should not add team' do
      get '/teams'
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end
end