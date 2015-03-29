class StaticPagesController < ApplicationController
  def home
    @games = Game.all
  end
end
