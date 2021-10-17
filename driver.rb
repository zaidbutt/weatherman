require_relative './yearly'
require_relative './Monthly'
require_relative './Daily'


abort('Invalid') if ARGV.length != 3

# class Weatherman

#   include Annual
#   include Monthly
#   include Daily
  
# end

# w = Weatherman.new
if ARGV[0] == '-e'
  include Annual
  abort('Invalid Command') if ARGV[1].length > 4  
  Annual.yearly_runner
  exit
end

if ARGV[0] == '-a'
  include Monthly
  # abort('Invalid Command') if ARGV[1].length > 4  
  Monthly.m_runner
  exit
end

if ARGV[0] == '-c'
  include Daily
  # abort('Invalid Command') if ARGV[1].length > 4  
  Daily.d_runner
  exit
end
