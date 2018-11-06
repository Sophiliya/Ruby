def score_throws(radiuses = [])
  return 0 if radiuses.empty?

  f_radius_less_5 = radiuses.map { |r| if r < 5 then 1 else 0 end }.min == 1

  scores = radiuses.inject(0) do |sum, r|
    if r < 5
      then sum += 10
    elsif r >= 5 && r <= 10
      then sum += 5
    else sum += 0
    end
  end

  total_scores = f_radius_less_5 ? scores + 100 : scores

end

p score_throws([])
p score_throws([1,5,11])
p score_throws([10,15,1,7])
p score_throws([1.5,2,5,6,8,13.7])
p score_throws([2,4,3,1])
