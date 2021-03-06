class PageController < ApplicationController
  before_filter :ensure_valid, :only => :show

  def show
    render :template => "page/#{current_page}"
  end

  protected

  def current_page
    params[:name].downcase
  end

  def ensure_valid
    unless template_exists?
      render :nothing => true, :status => :not_found and return false
    end
  end

  def template_exists?
    self.view_paths.find_template("page/#{current_page}", 'html') ? true : false
  rescue ActionView::MissingTemplate
    false
  end
end
