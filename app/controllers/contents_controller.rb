class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(
      title: content_params[:title],
      body: Content.sanitize(content_params[:body])
    )

    if @content.save
      TextToSpeech.perform_later(@content)

      redirect_to contents_path
    else
      render :new
    end
  end

  def show
    @content = Content.find(params[:id])
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    redirect_to contents_path
  end

  private

  def content_params
    params.require(:content).permit(:body, :title)
  end
end
