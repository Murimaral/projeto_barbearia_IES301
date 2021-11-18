# rubocop: disable Metrics/ClassLength
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end
end
# rubocop: enable Metrics/ClassLength
