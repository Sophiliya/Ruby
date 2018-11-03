
def ask(request)

  fail "Incorrect request: not a String!" unless request.is_a?(String)

  time = Time.now

  f_leap_year = ( time.year % 4 == 0 && time.year % 100 != 0 ) || ( time.year % 400 == 0 )
  days_in_year = f_leap_year ? 366 : 365
  remaining_days = days_in_year - time.yday

  answer =
  case request
  when  'time'
    then time.strftime("%H:%M")
  when 'date'
    then time.strftime("%d %B, %y")
  when 'day'
    then time.strftime("%A")
  when 'remaining days'
    then remaining_days
  when 'remaining weeks'
    then 53 - time.strftime("%V").to_i
  else 'Wrong request!'
  end

  return answer

end

  p ask('time')
  p ask('date')
  p ask('day')
  p ask('remaining days')
  p ask('remaining weeks')
  p ask('bla bla')
  p ask(1234)
