class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index
   @favs = current_user.favorites
  end

  def search

  end

  def show
    @search = params[:search]
    @client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
    @pagesize = 20
    @tracks = @client.get('/tracks', :q => @search, :licence => 'cc-by-sa', :limit => @pagesize, :offset => 2)
    
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

  end

  def destroy
   # Delete a single record in the database. 
   # Redirects the view to the root page using the root_path.

   # binding.pry
   favs = current_user.favorites
   favs.find(params[:id]).destroy
   redirect_to profile_path
  end

end
