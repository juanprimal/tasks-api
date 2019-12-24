class UserTasksController < ApplicationController
  before_action :set_user
  before_action :set_user_task, only: [:show, :update, :destroy]

  # GET /users/:user_id/user_tasks
  def index
    # json_response(@user.user_tasks)
    render json: @user.user_tasks, status: :ok
  end

  # GET /users/:user_id/user_tasks/:id
  def show
    # json_response(@user_task)
    render json: @user_task, status: :ok
  end

  # POST /users/:user_id/user_tasks
  def create
    @user.user_tasks.create!(user_task_params)
    # json_response(@user, :created)
    render json: @user, status: :created
  end

  # PUT /users/:user_id/user_tasks/:id
  def update
    @user_task.update(user_task_params)
    head :no_content
  end

  # DELETE /users/:user_id/user_tasks/:id
  def destroy
    @user_task.destroy
    head :no_content
  end

  private

  def user_task_params
    params.permit(:description, :state)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_task
    @user_task = @user.user_tasks.find_by!(id: params[:id]) if @user
  end
end