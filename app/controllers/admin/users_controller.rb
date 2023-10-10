class Admin::UsersController < ApplicationController
    before_action :admin_required

    def index
        @users = User.all.includes(:tasks)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.admin = params[:user][:admin] == 'true'
        if @user.save
            log_in(@user)
            flash[:success_registration] = 'ユーザを登録しました'
            redirect_to admin_users_path
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        @tasks = @user.tasks
    end

    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        @user.admin = params[:user][:admin] == 'true'
        if @user.update(user_params)
          flash[:success] = 'ユーザを更新しました'
          redirect_to admin_users_path
        else
          render :edit
        end
    end

    def destroy
    @user = User.find(params[:id])
    
    if @user.destroy_with_tasks
        flash[:success] = 'ユーザを削除しました'
    else
        flash[:alert] = '管理者が0人になるため削除できません'
    end

    redirect_to admin_users_path
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
end