require 'date'

DATE = 0
MAXTEMPERATURE = 1
MINTEMPERATURE = 3
MAXHUMIDITY = 7

def maximum_temp_record(arr)
  max_temp = []
  arr[1..-1].each do |i|
    max_temp.push(-100_000) if i[MAXTEMPERATURE].nil?
    max_temp.push(i[MAXTEMPERATURE].to_i) unless i[MAXTEMPERATURE].nil?
  end
  max_temp
end

def minimum_temp_record(arr)
  min_temp = []
  arr[1..-1].each do |i|
    min_temp.push(100_000) if i[MINTEMPERATURE].nil?
    min_temp.push(i[MINTEMPERATURE].to_i) unless i[MINTEMPERATURE].nil?
  end
  min_temp
end

def maximum_humidity_record(arr)
  max_humid = []
  arr[1..-1].each do |i|
    max_humid.push(-100_000) if i[MAXHUMIDITY].nil?
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

# This is the main Module
module Annual
  monthly = {}
  12.times do |i|
    mon = Date::ABBR_MONTHNAMES[i + 1]
    path = "./#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1]}_#{mon}.txt"
    next unless File.file?(path)
    file_data = File.open(path).readlines.map(&:chomp)
    arr = file_to_arr(file_data)
    month = arr[1][0].split('-')[1]
    max_temp = maximum_temp_record(arr)
    min_temp = minimum_temp_record(arr)
    max_humid = maximum_humidity_record(arr)
    maxday = max_temp.index(max_temp.max) + 1
    minday = min_temp.index(min_temp.min) + 1
    humidday = 
    m = [ max_temp.index(max_temp.max) + 1, maximum_temp_record(arr).max,
         min_temp.index(min_temp.min) + 1, min_temp.min,
         max_humid.index(max_humid.max) + 1,
         maximum_humidity_record(arr).max ]
    monthly[Date::MONTHNAMES[month.to_i]] = m
  end
  if monthly.empty?
    puts 'No record Found'
    exit
  end
  higest_record(monthly)
  lowest_record(monthly)
  total_humidity(monthly)
end
