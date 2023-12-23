pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function biri2()

end
function makepoints()
	a={
		x=rnd(127),
		y=rnd(127)
	}
	b={
		x=rnd(127),
		y=rnd(127)
	}
end

makepoints()
::_::
cls()
if btnp(4) then
	makepoints()
end

local step,points=20,{}
local w,h=
(a.x-b.x)/step,
(a.y-b.y)/step

for i=0,step do
	add(points,{
	x=a.x-w*i+rnd(4)-2,
	y=a.y-h*i+rnd(4)-2})
end

for i=1,#points-1 do
	local p,pn=
	points[i],points[i+1]
	line(p.x,p.y,pn.x,pn.y,9)
end

flip()
goto _
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
