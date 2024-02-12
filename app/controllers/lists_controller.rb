class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.save
    redirect_to lists_path
  end

  def show
    @list = List.find(params[:id])
    @movies_count = @list.movies.size
    @bookmarks = @list.bookmarks
    @bookmark = Bookmark.new
  end

  private

  def list_params
    params.require(:list).permit(:name, :image)
  end

end
