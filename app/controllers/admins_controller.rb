class AdminsController < ApplicationController

  def index
    organizations = Organization.search(params[:search])
  	organizations = Organization.all if params[:search].nil?
    @organizations = organizations.paginate(page: params[:page]).per_page(4).order("created_at DESC")
    respond_to do |format|
      format.html
      format.json { render json: @organizations, status: :ok }
    end
  end
end
