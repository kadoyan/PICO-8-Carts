pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()
	t=0
	x,y=0,0
	x1,y1=64,64
	x2,y2=64,64
	px1,py1=32,32
	px2,py2=90,90
	dst=60
end

function _update()
	t+=0.05
	if t>1 then
		t=0
		local r=rnd(1)
		px1,py1,
		px2,py2=
		cos(t-r)*dst+x1,
		sin(t-r)*dst+y1,
		cos(t+r)*dst+x1,
		sin(t+r)*dst+y1
	end

	local crv=curve(x1,y1,x2,y2,
		px1,py1,px2,py2)
	x,y=crv.x,crv.y
end

function _draw()
cls()
	pset(x1,y1,7)
	pset(x2,y2,7)
	pset(px1,py1,8)
	pset(px2,py2,8)
	circfill(x,y,2,8)
	print("t="..t,1,1,7)
	?("x="..x)
	?("y="..y)
end
-->8
function curve(
x1,y1,x2,y2,px1,py1,px2,py2)
	local x,y
	=(1-t)^3*x1+3*(1-t)^2*t*px1
		+3*(1-t)*t^2*px2+t^3*x2
	,(1-t)^3*y1+3*(1-t)^2*t*py1
		+3*(1-t)*t^2*py2+t^3*y2
	return {x=x,y=y}
end
__gfx__
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700999999990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700eeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dddddddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000