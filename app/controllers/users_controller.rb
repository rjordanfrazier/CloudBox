class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User successfully created"
      redirect_to login_path
    else
      flash.now[:danger] = "User cannot be saved"
      render new_user_path
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    if user_params[:password].blank? && !current_user?(@user)
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if @user.update_attributes(user_params)
      flash[:success] = "User updated successfully"
      redirect_to @user
    else
      flash[:danger] = "Unable to edit user"
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    redirect_to posts_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {}).permit(:username, :email, :password, :password_confirmation, :privilege)
  end
end
