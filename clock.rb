require 'active_support/time' # Allow numeric durations (eg: 1.minutes)
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
  every(5.seconds, 'Import Videos') do
    ::ImportVideos.perform_now
  end
end
