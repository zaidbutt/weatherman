# frozen_string_literal: true

require 'date'

def max_temp_record(arr)
  max_temp = []
  arr[1..-1].each do |i|
    next if i[MAXTEMPERATURE_INDEX].nil?

    max_temp.push(i[MAXTEMPERATURE_INDEX].to_i) unless i[MAXTEMPERATURE_INDEX].nil?
  end
  max_temp
end

def min_temp_record(arr)
  min_temp = []
  arr[1..-1].each do |i|
    next if i[MINTEMPERATURE_INDEX].nil?

    min_temp.push(i[MINTEMPERATURE_INDEX].to_i) unless i[MINTEMPERATURE_INDEX].nil?
  end
  min_temp
end

def max_humidity_record(arr)
  max_humid = []
  arr[1..-1].each do |i|
    next if i[MAXHUMIDITY_INDEX].nil?

    max_humid.push(i[MAXHUMIDITY_INDEX].to_i) unless i[MAXHUMIDITY_INDEX].nil?
  end
  max_humid
end

def file_to_arr(file_data)
  arr = []
  file_data.each do |i|
    next if i.empty? || i.start_with?('<')

    arr.push(i[0..-15].split(','))
  end
  arr
end

def path_extractor
  month = ARGV[1].split('/')[-1]
  year = ARGV[1].split('/')[0]
  mon = Date::ABBR_MONTHNAMES[month.to_i]
  "./#{ARGV[2]}/#{ARGV[2]}_#{year}_#{mon}.txt"
end

def average_calculate(arr)
  arr.inject(0) { |avg, val| avg + val }
end

def print_result(arr)
  puts "Highest Average: #{average_calculate(max_temp_record(arr)) / max_temp_record(arr).length}C
Lowest Average: #{average_calculate(min_temp_record(arr)) / min_temp_record(arr).length}C
Humidity Average: #{average_calculate(max_humidity_record(arr)) / max_humidity_record(arr).length}%"
  # puts ""
  # puts ""
end

# This module is for Monthly records
module Monthly
  def monthly_runner
    abort('Monthly File Not Found') unless File.file?(path_extract)
    arr = file_to_arr(File.open(path_extractor).readlines.map(&:chomp))
    print_result(arr)
  end
end
