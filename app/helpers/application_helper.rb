module ApplicationHelper
  require 'humanize'

  def number_to_human_readable(index)
    (index + 1).humanize
  end
end
