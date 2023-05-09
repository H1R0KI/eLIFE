class Public::GenresController < ApplicationController
  def create
    @genre = Genre.new(genre_params)
    @genre.save
    flash[:notice] = "通知：新しいジャンルを追加しました"
    redirect_to genres_path
  end
  
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    flash[:notice] = "通知：ジャンルを削除しました"
    redirect_to genres_path
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
