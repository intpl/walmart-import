class MainController < ApplicationController
  def index
  end

  def submit
    flash['notice'] = params[:url]
    redirect_to root_path
  end
end
