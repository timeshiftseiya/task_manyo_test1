class TasksController < ApplicationController
    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
          redirect_to root_path, notice: t('notice.task_created')
        else
          render :new
        end
    end
    
    def index
      @tasks = Task.all.order(created_at: :desc).page(params[:page])
    end

    def show
      @task = Task.find(params[:id])
    end
    
    def edit
      @task = Task.find(params[:id])
    end

    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to task_path(@task.id), notice: t('notice.task_updated')
      else
        render :edit
      end
    end

    def destroy
      @task = Task.find(params[:id]) 
      if @task.destroy
        flash[:notice] = t('notice.task_destroyed')
      end
        redirect_to tasks_path
    end

      private
    
    def task_params
        params.require(:task).permit(:title, :content)
    end
end
