require 'date'
# require './weather'

# DATE = 0
# MAXTEMPERATURE = 1
# MINTEMPERATURE = 3
# MAXHUMIDITY = 7

def max_temp_record(arr)
  max_temp = []
  arr[1..-1].each do |i|
    next if i[MAXTEMPERATURE].nil?
    max_temp.push(i[MAXTEMPERATURE].to_i) unless i[MAXTEMPERATURE].nil?
  end
  max_temp
end

def min_temp_record(arr)
  min_temp = []
  arr[1..-1].each do |i|
    next if i[MINTEMPERATURE].nil?
    min_temp.push(i[MINTEMPERATURE].to_i) unless i[MINTEMPERATURE].nil?
  end
  min_temp
end

def max_humidity_record(arr)
  max_humid = []
  arr[1..-1].each do |i|
    next if i[MAXHUMIDITY].nil?
    max_humid.push(i[MAXHUMIDITY].to_i) unless i[MAXHUMIDITY].nil?
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

def path_extract
  month = ARGV[1].split('/')[-1]
  year = ARGV[1].split('/')[0]
  mon = Date::ABBR_MONTHNAMES[month.to_i]
  "./#{ARGV[2]}/#{ARGV[2]}_#{year}_#{mon}.txt"
end

# This module is for Monthly records
module Monthly

  def m_runner
    abort('Monthly File Not Found') unless File.file?(path_extract)
    file_data = File.open(path_extract).readlines.map(&:chomp)
    arr = file_to_arr(file_data)
    max_temp = max_temp_record(arr)
    min_temp = min_temp_record(arr)
    hum = max_humidity_record(arr)
    max_result = max_temp.inject(0) { |avg, val| avg + val }
    puts "Highest Average: #{max_result / max_temp.length}C"
    min_result = min_temp.inject(0) { |avg, val| avg + val }
    puts "Lowest Average: #{min_result / min_temp.length}C"
    humidity_result = hum.inject(0) { |avg, val| avg + val }
    puts "Humidity Average: #{humidity_result / hum.length}%"
  end
  
end
