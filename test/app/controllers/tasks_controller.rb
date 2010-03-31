class TasksController < ApplicationController
  
  def new
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
end
