class OrganizationsController < ApplicationController
  # before_action :authenticate_seller
  before_action :set_new

  def index
  	@search = Organization.ransack(params[:q])
    @search.sorts = 'org_name asc' if @search.sorts.empty?
    @search.sorts = 'org_identifier asc' if @search.sorts.empty?
    @search.sorts = 'country asc' if @search.sorts.empty?
  	organizations = Organization.order(org_name: :asc) if params[:order] == "asc"
    organizations = Organization.search(params[:search])
  	organizations = Organization.all if params[:search].nil?
    @organizations = organizations.paginate(page: params[:page]).per_page(4).order("created_at DESC")
    respond_to do |format|
      format.html
      format.json { render json: @organizations, status: :ok }
    end
  end

  def create
    @user = current_user.id
    @organization = Organization.new(organization_params)
    @organization.user_id = @user
    respond_to do |format|
      if @organization.save
        format.json {render json: @organization, status: :created}
        format.js {redirect_to homes_path}
        format.html {redirect_to home_path, flash: { success: "Invoice Saved Successfully" }}
      else
        format.json {render json: @organization.errors.full_messages, status: :unprocessable_entity }
        format.js
        format.html {redirect_to invoices_path, flash: { error: @organization.errors.full_messages }}
      end
    end
  end


  def edit
  end

  def show
  end



  private

  def set_new
  	@organization = Organization.new
  end

  def organization_params
  	params.require(:organization).permit(:org_name,:org_identifier,:first_name,:last_name,:address_line1,:address_line2,:city,:state,:country,:zip_code)
  end




end
