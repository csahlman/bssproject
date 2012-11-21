class PagesController < ApplicationController
  skip_before_filter :authenticate, only: [ :home, :about, :contact ]
  def home
    
  end

  def about
  end

  def contact
  end
end
