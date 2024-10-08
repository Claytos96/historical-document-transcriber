class DocumentsController < ApplicationController

  def index
    @documents = Document.all
    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @documents = @documents.where("LOWER(title) LIKE ? or LOWER(description) LIKE ?", query, query)
    end
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user = current_user
    @document.save!
    redirect_to root_path
  end

  def show
    @document = Document.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to documents_path, alert: 'Document not found.'
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    @document.update(document_params)
    redirect_to documents_path
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
  end

  private

  def document_params
    params.require(:document).permit(:image, :title, :description, :transcription, :user_id, :file)
  end
end
