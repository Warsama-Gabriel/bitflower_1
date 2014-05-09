class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index

   @favs = current_user.favorites
   unless params[:code].nil?
    @client = SoundCloud.new({
      :client_id     => ENV['SOUNDCLOUD_CLIENT_ID'],
      :client_secret => ENV['SOUNDCLOUD_CLIENT_SECRET'],
      :redirect_uri  => 'http://localhost:3000/you/profile'
    })
    code = params[:code]
    access_token = @client.exchange_token(:code => code)
    current_user.access_token = access_token[:access_token]
    current_user.save
   end
  end

  def search

  end

  def show

    @search = params[:search]
    @client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
    @pagesize = 10
    @page = params[:page]
    @tracks = @client.get('/tracks', :q => @search, :licence => 'cc-by-sa', 
    :limit => @pagesize, :offset => @page)
  end

  def fav
    @id = params[:id] #store the track id
    @favs = Favorite.new
    @favs.track_id = @id
    @favs.user_id = current_user.id 
    @favs.save
    redirect_to profile_path
  end

  def update
  favs = current_user.favorites
  favs.find(params[:id]).destroy
  redirect_to search_path
  end

  def soundcloud
    @client = SoundCloud.new({
      :client_id     => ENV['SOUNDCLOUD_CLIENT_ID'],
      :client_secret => ENV['SOUNDCLOUD_CLIENT_SECRET'],
      :redirect_uri  => ENV['REDIRECT_URL']
    })
    redirect_to @client.authorize_url()
     
  end

  def tweet
    @client = Soundcloud.new(:access_token => current_user.access_token)
    @connection = @client.get('/me/connections').find { |c| c.type == 'twitter' }

    track_id = params[:track_id]

    @client.post("/tracks/#{track_id}/shared-to/connections",
      :connections => [{:id => @connection.id}],
      :sharing_note => 'Check out my new sound')

    redirect_to profile_path
  end

  def destroy
   favs = current_user.favorites
   favs.find(params[:id]).destroy
   redirect_to profile_path
  end
end
