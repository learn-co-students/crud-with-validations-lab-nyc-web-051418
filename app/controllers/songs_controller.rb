class SongsController < ApplicationController

  def index
@songs=Song.all
  end

  def edit
@song=Song.find(params[:id])
  end

  def show
@song=Song.find(params[:id])
  end
def new
@song=Song.new
end

  def create
    # byebug
@song=Song.create(strong_params(:title,:release_year,:released,:genre,:artist_name))
if @song.valid?
  @song.save
  redirect_to @song
else
  render :new
end
  end

  def update
@song=Song.find(params[:id])
if @song.update(strong_params(:title,:release_year,:released,:genre,:artist_name))
  redirect_to @song
else
  render :edit
end
  end

  def destroy
Song.find(params[:id]).destroy
 redirect_to songs_url

  end

  private
  def strong_params(*args)
    params.require(:song).permit(*args)
  end
end
