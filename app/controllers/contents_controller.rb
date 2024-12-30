class ContentsController < ApplicationController
  before_action :set_content, only: %i[show edit destroy]

  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(
      title: content_params[:title],
      body: Content.sanitize(content_params[:body]),
      category_id: content_params[:category_id]
    )

    if @content.save
      TextToSpeech.perform_later(@content)

      redirect_to contents_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @content.assign_attributes(
      title: content_params[:title],
      body: Content.sanitize(content_params[:body]),
      category_id: content_params[:category_id]
    )

    if @content.save
      TextToSpeech.perform_later(@content)

      redirect_to contents_path
    else
      render :edit
    end
  end

  def destroy
    @content.destroy

    redirect_to category_path(@content.category)
  end

  private

  def set_content
    @content = Content.find(params.require(:id))
  end

  def content_params
    params.require(:content).permit(:body, :title, :category_id)
  end
end
