# frozen_string_literal: true

require_relative './yearly'
require_relative './monthly'
require_relative './daily'

abort('Invalid') if ARGV.length != 3

class Weatherman1
  include Annual

  # yearly_runner
  # include Monthly
  # include Daily
end

class Weatherman2
  include Monthly
  # include Daily
end

class Weatherman3
  include Daily
end

if ARGV[0] == '-e'
  Weatherman1.new.yearly_runner
  abort('Invalid Command') if ARGV[1].length > 4

elsif ARGV[0] == '-a'

  # abort('Invalid Command') if ARGV[1].length > 4
  Weatherman2.new.monthly_runner

elsif ARGV[0] == '-c'

  # abort('Invalid Command') if ARGV[1].length > 4
  Weatherman3.new.daily_runner
elsif ARGV[1].length > 4
  abort('Invalid Command')
end
