# frozen_string_literal: true

require 'date'

DATE_INDEX = 0
MAXTEMPERATURE_INDEX = 1
MINTEMPERATURE_INDEX = 3
MAXHUMIDITY_INDEX = 7

def maximum_temp_record(arr)
  max_temp = []
  arr[1..-1].each do |i|
    max_temp.push(-100_000) if i[MAXTEMPERATURE_INDEX].nil?
    max_temp.push(i[MAXTEMPERATURE_INDEX].to_i) unless i[MAXTEMPERATURE_INDEX].nil?
  end
  max_temp
end

def minimum_temp_record(arr)
  min_temp = []
  arr[1..-1].each do |i|
    min_temp.push(100_000) if i[MINTEMPERATURE_INDEX].nil?
    min_temp.push(i[MINTEMPERATURE_INDEX].to_i) unless i[MINTEMPERATURE_INDEX].nil?
  end
  min_temp
end

def maximum_humidity_record(arr)
  max_humid = []
  arr[1..-1].each do |i|
    max_humid.push(-100_000) if i[MAXHUMIDITY_INDEX].nil?
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

def higest_record(record)
  max = []
  record.each_value { |value| max.push(value[1]) }
  k = max.index(max.max)
  puts "Highest: #{max.max}C on #{record.keys[k]} #{record[record.keys[k]][0]} "
end

def lowest_record(record)
  min = []
  record.each_value { |value| min.push(value[3]) }
  k = min.index(min.min)
  puts "Lowest: #{min.min}C on #{record.keys[k]} #{record[record.keys[k]][2]} "
end

def total_humidity(record)
  hum = []
  record.each_value { |value| hum.push(value[-1]) }
  k = hum.index(hum.max)
  puts "Humid #{hum.max}% on #{record.keys[k]} #{record[record.keys[k]][-2]}"
end

def valid_paths
  path = []
  12.times do |i|
    mon = Date::ABBR_MONTHNAMES[i + 1]
    pth = "./#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1]}_#{mon}.txt"
    next unless File.file?(pth)

    path.push(pth)
  end
  path
end

def monthly_record_getter(arr)
  # max_temp = maximum_temp_record(arr)
  # min_temp = minimum_temp_record(arr)
  # max_humid = maximum_humidity_record(arr)
  [maximum_temp_record(arr).index(maximum_temp_record(arr).max) + 1, maximum_temp_record(arr).max,
   minimum_temp_record(arr).index(minimum_temp_record(arr).min) + 1, minimum_temp_record(arr).min,
   maximum_humidity_record(arr).index(maximum_humidity_record(arr).max) + 1,
   maximum_humidity_record(arr).max]
end

# This is the main Module
module Annual
  def yearly_runner
    monthly = {}
    valid_paths.each do |i|
      arr = file_to_arr(File.open(i).readlines.map(&:chomp))
      monthly[Date::MONTHNAMES[arr[1][0].split('-')[1].to_i]] = monthly_record_getter(arr)
    end
    abort('No record Found') if monthly.empty?

    higest_record(monthly)
    lowest_record(monthly)
    total_humidity(monthly)
  end
end
