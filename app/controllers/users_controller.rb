# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, except: [:password_digest], status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    render(json: @user) && return if @user.update(user_params)

    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end

  def destroy
    return if @user.destroy

    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(
      :name, :email, :password
    )
  end
end
