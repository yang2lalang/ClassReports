plotLine(x0,y0, x1,y1)
  dx=x1-x0
  dy=y1-y0

  D = 2*dy - dx
  plot(x0,y0)
  y=y0

  for x = x0+1 : x1
    if D > 0
      y = y+1
      plot(x,y)
      D = D + (2*dy-2*dx)
    else
      plot(x,y)
      D = D + (2*dy)
    end
  end
    