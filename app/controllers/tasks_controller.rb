class TasksController < ApplicationController
    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
          # flash[:success] = 'Task was successfully created.'
          # redirect_to root_path
          redirect_to root_path, notice: 'Task was successfully created.'
        else
          render :new
        end
    end
    
    def index
      @tasks = Task.all
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
        flash[:success] = 'Task was successfully updated.'
        redirect_to task_path(@task.id)
      else
        render :edit
      end
    end

    def destroy
      @task = Task.find(params[:id]) 
      if @task.destroy
        flash[:notice] = 'Task was successfully destroyed.'
      end
      redirect_to tasks_path
    end

      private
    
    def task_params
        params.require(:task).permit(:title, :content)
    end
end
