require 'holidays'
require 'generated_definitions/au'
require 'biz'
require 'active_support/all'
require 'holidays/core_extensions/date'

class Date
  include Holidays::CoreExtensions::Date
end

from = 1.years.ago
to = 1.years.from_now

Holidays.cache_between(from, to, :au, :au_nsw, :au_vic, :au_qld, :au_nt, :au_act, :au_sa, :au_wa, :au_tas)

holidays = Holidays.between(from, to, :au, :au_nsw, :au_vic, :au_qld, :au_nt, :au_act, :au_sa, :au_wa, :au_tas)

puts holidays
puts holidays.class
puts holidays[0]
puts holidays[0].class
puts holidays[0][:date]

holiday_array = []
holidays.each { |x| holiday_array.push(x[:date]) }

puts holiday_array

Biz.configure do |config|
  config.hours = {
    mon: {'08:00' => '18:00'},
    tue: {'08:00' => '18:00'},
    wed: {'08:00' => '18:00'},
    thu: {'08:00' => '18:00'},
    fri: {'08:00' => '18:00'}
  }

  config.holidays = holiday_array

  config.time_zone = 'Australia/Brisbane'
end

# Find the time an amount of business time *before* a specified starting time
puts Biz.time(30, :minutes).before(Time.utc(2015, 1, 1, 11, 45))

# Find the time an amount of business time *after* a specified starting time
puts Biz.time(2, :hours).after(Time.utc(2015, 12, 25, 9, 30))

# Calculations can be performed in seconds, minutes, hours, or days
puts Biz.time(1, :day).after(Time.utc(2015, 1, 8, 10))

# Find the amount of business time between two times
puts Biz.within(Time.utc(2015, 3, 7), Time.utc(2015, 3, 14)).in_seconds

# Determine if a time is in business hours
puts Biz.in_hours?(Time.utc(2015, 1, 10, 9))

# Determine if a time is on a holiday
puts Biz.on_holiday?(Time.utc(2014, 1, 1))
