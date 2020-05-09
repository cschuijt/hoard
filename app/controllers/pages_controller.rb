class PagesController < ApplicationController
  def home
    render layout: "no_navbar"
  end
end
