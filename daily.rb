# frozen_string_literal: true

require 'date'
# require './weather'
require 'colorize'

def path_extract
  month = ARGV[1].split('/')[-1]
  year = ARGV[1].split('/')[0]
  mon = Date::ABBR_MONTHNAMES[month.to_i]
  # p Date::ABBR_MONTHNAMES[month.to_i]
  "./#{ARGV[2]}/#{ARGV[2]}_#{year}_#{mon}.txt"
end

def min_temp_print(min_temp, itr)
  print itr + 1
  min_temp[itr].times do |_a|
    print '+'.blue
  end
  puts min_temp[itr]
end

def max_temp_print(max_temp, min_temp)
  max_temp.length.times do |i|
    next if max_temp[i] == -100_000 || min_temp[i] == 100_000

    print "#{i + 1} "
    max_temp[i].times do |_a|
      print '+'.red
    end
    puts max_temp[i]
    min_temp_print(min_temp, i)
  end
end

# This is a daily record Module
module Daily
  def daily_runner
    arr = file_to_arr(File.open(path_extract).readlines.map(&:chomp))
    max_temp = maximum_temp_record(arr)
    min_temp = minimum_temp_record(arr)
    max_temp_print(max_temp, min_temp)
  end
end
