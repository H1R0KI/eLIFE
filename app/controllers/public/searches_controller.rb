class Public::SearchesController < ApplicationController

  def search
    @tags = Tag.all
    @model = params["model"] #投稿orユーザー
    @content = params["content"] #フォームで入力したキーワード
    @method = params["method"] #一致条件

    if @model == "post"
      @posts = Post.search_for(@content, @method).page(params[:page])
      render "public/searches/search_result"
    else
      @members = Member.search_for(@content, @method).page(params[:page])
      render "public/searches/search_result"
    end
  end

  def item_search
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

end
