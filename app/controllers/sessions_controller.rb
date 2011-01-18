class SessionsController < ApplicationController

  layout 'front_layout'

  def new
  end

  def create
    authenticate!
    redirect_to dashboard_path
  end

  def destroy
    logout
    redirect_to root_path
  end

  def unauthenticated
    redirect_to root_path
  end

end