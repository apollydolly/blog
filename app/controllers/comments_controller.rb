class CommentsController < ApplicationController

  #http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy
  before_action :authenticate_user!, except: [:destroy]
  def create
    # @article = Article.find(params[:article_id])
    # @article = Article.find_by(title: params[:article_title].gsub('-', ' '))
    @article = Article.friendly.find(params[:article_slug])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    # @article = Article.find(params[:article_id])
    # @article = Article.find_by(title: params[:article_title].gsub('-', ' '))
    @article = Article.friendly.find(params[:article_slug])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end

