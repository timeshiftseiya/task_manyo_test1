class Admin::UsersController < ApplicationController
    def index
        @users = User.all.includes(:tasks)
    end

    def new
        @user = User.new(user_params)
        @user.admin = params[:user][:admin] == '1'
    end

    def show
        @user = User.find(params[:id])
        @tasks = @user.tasks
    end

    def edit
        @user = User.find(params[:id])
    end

  end