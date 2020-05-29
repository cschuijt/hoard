class PagesController < ApplicationController
  def home
    if user_signed_in?
      render 'landing'
    else
      render layout: "no_partials"
    end
  end
end
