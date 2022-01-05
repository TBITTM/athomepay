class TasksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc), items: 15)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
      @task = Task.new
  end

  def create
      @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = 'お手伝い項目が正常に保存されました'
      redirect_to @task
    else
      flash.now[:danger] = 'お手伝い項目が保存されませんでした'
      render :new
    end
  end


  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'お手伝い項目が正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'お手伝い項目は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
      @task.destroy

      flash[:success] = 'お手伝い項目は正常に削除されました'
      redirect_to tasks_url
  end
  
  # Strong Parameter

  def task_params
      params.require(:task).permit(:content, :price)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  
  
  
end
