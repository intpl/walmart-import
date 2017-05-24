class MainController < ApplicationController
  def index
    @products = Product.all
  end

  def submit
    ScrapeProductJob.new.perform(params[:url])
    flash['notice'] = 'started importing product background job...'
    redirect_to root_path
  end
end
