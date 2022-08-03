pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
	a={}
	for i=1,60 do
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
	for a in all(a) do
		calc_tri(a,a.x,a.y)
	end
end

function _draw()
	cls()
	for n=1,#a do
		draw_tri(a[n],n%14+1)
	end
	print("cpu:"..stat(1),1,1,15)
	print("num of:"..#a,1,7,15)
end
-->8
--functions

--get x axis of the point on the line
p2calc=function(x1,y1,x2,y2,y)
	local x=
	x1+((x2-x1)*(y-y1))/(y2-y1)
	return x
end

--sort table
--original code:
--https://pico-8.fandom.com/wiki/Qsort
function qsort(a,c,l,r)
	c,l,r=c or function(a,b) return a<b end,l or 1,r or #a
	if l<r then
		if c(a[r],a[l]) then
			a[l],a[r]=a[r],a[l]
		end
		local lp,k,rp,p,q=l+1,l+1,r-1,a[l],a[r]
		while k<=rp do
			local swaplp=c(a[k],p)
			if swaplp or c(a[k],q) then
			else
				while c(q,a[rp]) and k<rp do
					rp-=1
				end
				a[k],a[rp],swaplp=a[rp],a[k],c(a[rp],p)
				rp-=1
			end
			if swaplp then
				a[k],a[lp]=a[lp],a[k]
				lp+=1
			end
			k+=1
		end
		lp-=1
		rp+=1
		a[l],a[lp]=a[lp],a[l]
		a[r],a[rp]=a[rp],a[r]
		qsort(a,c,l,lp-1       )
		qsort(a,c,lp+1,rp-1  )
		qsort(a,c,rp+1,r)
	end
end

--rotate
rotate=function(t,cx,cy,r)
	local c,s=cos(r),sin(r)
	local x,y=t.x,t.y
	nx=c*x+-s*y+cx
	ny=s*x+c*y+cy
	return {x=nx,y=ny}
end

--get random
frnd=function(n,p)
	return flr(rnd(n)+p)
end
-->8
--move triangle
draw_tri=function(t,c)
	local c=c or 7
	for y=t[1].ny,t[2].ny do
		local x1=
		p2calc(t[1].nx,t[1].ny,
		t[2].nx,t[2].ny,y)
		local x2=
		p2calc(t[1].nx,t[1].ny,
		t[3].nx,t[3].ny,y)
		line(x1,y,x2,y,c)
	end
	for y=t[2].ny,t[3].ny do
		local x1=
		p2calc(t[2].nx,t[2].ny,
		t[3].nx,t[3].ny,y)
		local x2=
		p2calc(t[1].nx,t[1].ny,
		t[3].nx,t[3].ny,y)
		line(x1,y,x2,y,c)
	end
end

calc_tri=function(t,x,y)
	local x,y=
	x or 63,
	y or 63
	for p in all(t) do
		local np=rotate(p,t.cx,t.cy,cnt)
		p.nx,p.ny=np.x,np.y
	end
	qsort(t,
		function(a,b)
		return a.ny < b.ny end
	)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
