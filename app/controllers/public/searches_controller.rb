class Public::SearchesController < ApplicationController

  before_action :authenticate_member!

  def search
    @tags = Tag.all
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]

    if @model == "post"
      @posts = Post.search_for(@content, @method)
      render "public/searches/search_result"
    else
      @members = Member.search_for(@content, @method)
      render "public/searches/search_result"
    end
  end

end
