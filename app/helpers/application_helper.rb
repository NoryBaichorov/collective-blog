# frozen_string_literal: true

module ApplicationHelper
  include ActionView::Helpers::DateHelper

  def pretty_time_ago(time)
    "#{distance_of_time_in_words(Time.zone.now - time)} ago"
  end

  def format_date(date)
    date.strftime('%-d %b., %H:%M')
  end
end
