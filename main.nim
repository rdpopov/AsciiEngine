import ncurses

import engine


if isMainModule:
  var wind:PWindow = initscr()
  var next_piece  = GenerateField()
  wind.nodelay(true)
  noecho()
  var p:array[300,int]
  for i in 0..299:
    p[i] = wind.wgetch()
    napms(17)
    wind.wclear()
  wind.waddstr($wind.getmaxx & "\n")
  wind.waddstr($wind.getmaxy & "\n")
  wind.wrefresh()
  endwin()
  for i in items(p):
    if i != ERR:
     stdout.write(char(i)&"\n\r")
