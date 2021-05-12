import strutils
import ncurses

const x_dim = 0
const y_dim = 1

type
  Field* = object
    field* : seq[string]
    o_offs* : array[2,int]

proc GenerateField(s_x,s_y:int):ref Field= 
  result = new Field
  result[].o_offs = [s_x,s_y]
  result[].field.setLen(s_y)
  for i in mitems(result[].field):
    i = ' '.repeat(s_x)
  return result

proc RenderField(f:Field,wind:PWindow,x,y:int)=
  for i in items (f.field):
    if wind.mvwaddstr(cint(y),cint(x), cstring(i)) == ERR:
      assert(true,"Failed To Draw")

proc MoveToAbs(f:Field,wind:PWindow,x,y:int)=
  var x_lim : array[2,int] = [0, wind.getmaxx]
  var y_lim : array[2,int] = [0, wind.getmaxy]
  var tmp_x:int = f.o_offs[x_dim] + x
  var tmp_y:int = f.o_offs[y_dim] + y
  if x_lim[0] > tmp_x:
  if x_lim[0] > tmp_x:
  if y_lim[0] > tmp_x:
  if y_lim[0] > tmp_x:



