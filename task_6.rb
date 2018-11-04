def ask(request)

  return p "Incorrect request: not a String!" unless request.is_a?(String)

  time = Time.now

  f_leap_year = ( time.year % 4 == 0 && time.year % 100 != 0 ) || ( time.year % 400 == 0 )
  days_in_year = f_leap_year ? 366 : 365
  remaining_days = days_in_year - time.yday

  answer =
  case request
  when  'time'
    time.strftime("%H:%M")
  when 'date'
    time.strftime("%d %B, %y")
  when 'day'
    time.strftime("%A")
  when 'remaining days'
    remaining_days
  when 'remaining weeks'
    53 - time.strftime("%V").to_i
  else 'Incorrect request!'
  end

  p answer

end

  ask('time')
  ask('date')
  ask('day')
  ask('remaining days')
  ask('remaining weeks')
  ask('bla bla')
  ask(1234)
