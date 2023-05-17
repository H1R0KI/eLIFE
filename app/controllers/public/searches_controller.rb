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
    @keyword = params[:keyword]
    #キーワードの文字数による分岐条件
    if @keyword.length.to_i >= 2 #２文字以上の場合のみ検索結果を
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    else
      flash[:notice] = "通知：キーワードは2文字以上で検索して下さい"
      redirect_to request.referer
    end
  end

end
