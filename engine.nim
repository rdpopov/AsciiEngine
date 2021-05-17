import strutils
import ncurses

const x_dim = 0
const y_dim = 1

const up = 0
const down = 1
const left = 2
const right = 3

type
  Field* = object
    field* : seq[string]
    size* : array[2,int]
    origin*: array[2,int]
    cut*: array[4,int]

proc GenerateField(s_x,s_y,o_x,o_y:int):ref Field= 
  result = new Field
  result[].size = [s_x,s_y]
  result[].origin = [o_x,o_y]
  result[].field.setLen(s_y)
  for i in mitems(result[].field):
    i = ' '.repeat(s_x)
  return result

proc RenderField(f:Field,wind:PWindow,x,y:int)=
  for i in items 0+..f.field.high():
    if wind.mvwaddstr(cint(y),cint(x), cstring(i[0+])) == ERR:
      assert(true,"Failed To Draw")

proc MoveAbsolute(f:var Field,wind:PWindow,x,y:int,cut:bool= false)=
  var x_lim : array[2,int] = [0, wind.getmaxx]
  var y_lim : array[2,int] = [0, wind.getmaxy]
  var tmp_x:int = f.size[x_dim] + x
  var tmp_y:int = f.size[y_dim] + y
  #cut means if the thing can go past the border
  # TODO probably have to refactor that?
  if cut:
    if x_lim[0] > tmp_x:
      f.cut[left] = abs(x_lim[0] - tmp_x)
    if x_lim[1] < tmp_x:
      f.cut[right] = abs(tmp_x - x_lim[1])
    if y_lim[0] > tmp_y:
      f.cut[up] = abs(y_lim[0] - tmp_y)
    if y_lim[1] > tmp_y:
      f.cut[down] = abs(tmp_y - x_lim[1])
  else:
    f.cut = [0,0,0,0]
    if x_lim[0] > tmp_x:
      f.origin[x_dim] = 0
    if x_lim[1] < tmp_x:
      f.origin[x_dim] = x_lim[1] - f.size[x_dim]
    if y_lim[0] > tmp_y:
      f.origin[y_dim] = 0
    if y_lim[1] > tmp_y:
      f.origin[y_dim] = y_lim[1] - f.size[y_dim]


