def fibonacci(n)
  fi = [0,1]

  while ( sum = fi[-1] + fi[-2] ) < n do
    fi << sum
  end

  fi

end

p fibonacci(100) 
