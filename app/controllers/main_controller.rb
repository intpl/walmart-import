class MainController < ApplicationController
  def index
    @products = Product.all.includes(:reviews)
  end

  def submit
    ScrapeProductJob.new.perform(params[:url])
    flash['notice'] = 'started importing product background job...'
  rescue ActiveRecord::RecordNotUnique
    flash['error'] = 'product already exists'
  ensure
    redirect_to root_path
  end
end
