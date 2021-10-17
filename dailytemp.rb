require 'date'
# require './weather'
require 'colorize'

def path_extractor
  month = ARGV[1].split('/')[-1]
  year = ARGV[1].split('/')[0]
  mon = Date::ABBR_MONTHNAMES[month.to_i]
  "./#{ARGV[2]}/#{ARGV[2]}_#{year}_#{mon}.txt"
end

# This is a daily record Module
module Daily
  # include Annual
  abort('Daily File Not Found') unless File.file?(path_extractor)
  arr = file_to_arr(File.open(path_extractor).readlines.map(&:chomp))
  max_temp = maximum_temp_record(arr)
  min_temp = minimum_temp_record(arr)
  max_temp.length.times do |i|
    next if max_temp[i] == -100_000 || min_temp[i] == 100_000
    print "#{i + 1} "
    max_temp[i].times do |_a|
      print '+'.red
    end
    puts max_temp[i]
    print i + 1
    min_temp[i].times do |_a|
      print '+'.blue
    end
    puts min_temp[i]
  end
end
