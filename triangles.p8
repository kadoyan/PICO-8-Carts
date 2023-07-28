pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
	a={}
	r={}
	draw=0
	for i=1,90 do
		add(a,{
			{x=frnd(100,-20),
				y=frnd(100,-20)},
			{x=frnd(100,-20),
				y=frnd(100,-20)},
			{x=frnd(100,-20),
				y=frnd(100,-20)},
			cx=frnd(127,0),
			cy=frnd(127,0)
		})
	end
	--counter
	cnt=0
end

function _update()
	cnt+=0.01
	r={}
	for n=1,#a do
		add(r,calc_tri(a[n]))
	end
end

function _draw()
	cls()
	for n=1,#r do
		draw_tri(r[n],n%14+1)
	end
	print("cpu:"..stat(1),1,1,15)
	print("num of:"..#a,1,7,15)
	print("line:"..draw,1,13,15)
	draw=0
end
-->8
--functions

--get x axis of the point on the line
p2calc=function(x1,y1,x2,y2,y)
	local x=
	x1+((x2-x1)*(y-y1))/(y2-y1)
	return x
end

--get random
frnd=function(n,p)
	return flr(rnd(n)+p)
end
-->8
--move triangle
draw_tri=function(t,c)
	local c=c or 7
	color(c)
	--exclude triangles out of screen
	local min_x=min(t[1].x,min(t[2].x,t[3].x))
	if(min_x>127)return
	local max_x=max(t[1].x,max(t[2].x,t[3].x))
	if(max_x<0)return
	local min_y=min(t[1].y,min(t[2].y,t[3].y))
	if(min_y>127)return
	local max_y=max(t[1].y,max(t[2].y,t[3].y))
	if(max_y<0)return

	--set numbers to interger
	local x1,x2,x3,y1,y2,y3=
	t[1].x&0xffff,
	t[2].x&0xffff,
	t[3].x&0xffff,
	t[1].y&0xffff,
	t[2].y&0xffff,
	t[3].y&0xffff

	if y2>y3 then
		y2,y3=y3,y2
		x2,x3=x3,x2
	end
	if y1>y2 then
		y1,y2=y2,y1
		x1,x2=x2,x1
	end
	if y2>y3 then
		y2,y3=y3,y2
		x2,x3=x3,x2
	end
	if y1!=y2 then
		for y=y1,y2 do
			local nx1=
			p2calc(x1,y1,x2,y2,y)
			local nx2=
			p2calc(x1,y1,x3,y3,y)
			rectfill(nx1,y,nx2,y)
			draw+=1
		end
	end
	if y2!=y3 then
		for y=y2,y3 do
			local nx1=
			p2calc(x2,y2,x3,y3,y)
			local nx2=
			p2calc(x1,y1,x3,y3,y)
			rectfill(nx1,y,nx2,y)
			draw+=1
		end
	end
end

calc_tri=function(t)
	local n={}
	for p in all(t) do
		local np=rotate(p,t.cx,t.cy,cnt)
		add(n,{x=np.x,y=np.y})
	end
	return n
end

--rotate
rotate=function(t,cx,cy,r)
	local c,s=cos(r),sin(r)
	local x,y=t.x,t.y
	nx=c*x+-s*y+cx
	ny=s*x+c*y+cy
	return {x=nx,y=ny}
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
