pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
p={}--stars
h=0--horizontal vector
v=0--vertical vector
b=2--boost
ha,va=0,0-- acceleration
r=128--random seed
l={1,5,6,13}--color

--draw stars
for i=1,100 do
	add(p,{
		x=rnd(r),
		y=rnd(r),
		s=rnd(16)/4,
		c=l[ceil(rnd(#l))]
	})
end

function _update()
	h,v=0,0
	if btn(0) then h=1 end
	if btn(1) then h=-1 end
	if btn(2) then v=1 end
	if btn(3) then v=-1 end
	if h!=0 then ha+=.1*h	end
	if v!=0 then	va+=.1*v	end
	if va<=-2 then va=-2 end
	if va>=2 then va=2 end
	if ha<=-2 then ha=-2 end
	if ha>=2 then ha=2 end
end

function _draw()
	cls()
	for i=1,#p do
		s=p[i].s
		x=p[i].x+s*ha
		y=p[i].y+s*va
		c=p[i].c
		pset(x,y,c)
		p[i].x=x
		p[i].y=y
		if y<0 then p[i].y=128 end
		if y>128 then p[i].y=0 end
		if x<0 then p[i].x=128 end
		if x>128 then p [i].x=0 end
	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000