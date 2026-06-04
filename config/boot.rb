ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# These stdlib gems were extracted in Ruby 3.3+ and must be loaded early,
# before ActiveSupport is required.
require "logger"
require "bigdecimal"
require "mutex_m"
require "ostruct"

require "bundler/setup" # Set up gems listed in the Gemfile.
