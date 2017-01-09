class LinksController < ApplicationController
  before_action :authorize

  def index
    @hot_links = Link.hot
  end

  def edit
  end

  def update
  end
end
