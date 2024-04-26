class ApplicationController < ActionController::Base
  include ActionView::Helpers::DateHelper

  def beauty_time(time)
    distance_of_time_in_words(Time.now - time)
  end

  helper_method :beauty_time
end
