class AdminsController < ApplicationController

  def index
  	# @search = Organization.ransack(params[:q])
   #  @search.sorts = 'org_name asc' if @search.sorts.empty?
   #  @search.sorts = 'org_identifier asc' if @search.sorts.empty?
   #  @search.sorts = 'country asc' if @search.sorts.empty?
   #  organizations = Organization.order(org_name: :asc) if params[:order] == "org_name"
  	# organizations = Organization.order(org_name: :asc) if params[:order] == "asc"
  	user = User.find_by(params[:email])
  	p "#{user.email}>>>>>>>>>>>>>>>>>>SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
    organizations = Organization.search(params[:search])
  	organizations = Organization.all if params[:search].nil?
    @organizations = organizations.paginate(page: params[:page]).per_page(4).order("created_at DESC")
    respond_to do |format|
      format.html
      format.json { render json: @organizations, status: :ok }
    end
  end
end
