pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()
	laser=homing()
	pl=player()
	t=0
	enemies={}
end

function _update60()
	t+=1
	pl.move()
	laser.move()
	
	-- for demo
	if btn(❎) then
		add(enemies,{
			x=rnd(127),
			y=0
		})
		laser.settarget(
			enemies[#enemies])
	end
	for e in all(enemies) do
		e.y+=2
		if e.y>128 then
			del(enemies,e)
		end
	end
end

function _draw()
	cls()
	pl.draw()
	laser.draw()
	
	?stat(0)
	?stat(1)
	?#laser.scan
	?#enemies
end
-->8
function homing()
	local laser={
		scan={}
	}
	laser.settarget=function(e)
		add(laser.scan,{
			target=e,
			ctlpoint={
				x=pl.x,
				--turn back
				y=pl.y+50+rnd(50)
			},
			step={},
			stepn=1,
			--shot delay
			delay=2--#laser.scan*2
		})
	end
	
	laser.move=function()
		for s in all(laser.scan) do
			s.delay-=1
			if s.delay<=0 then
				local t,p
					=s.target,s.ctlpoint
				local dist=
					(0.2-get_dist(pl,t)*
					0.001)*.75
				-- laser
				s.step={}
				for i=0,1+dist*.5,dist do
					add(s.step,curve({
						x=pl.x,
						y=pl.y
					},t,p,i))
				end
			end
			if t%2==0 then
				s.stepn+=1
				if s.stepn>#s.step then
					del(laser.scan,s)
				end
			end
		end
	end
	
	laser.draw=function()
		for s in all(laser.scan) do
			for i=0,3 do
				local n,endn
					=s.stepn+i,s.stepn+i+1
				n=min(n,#s.step)
				endn=min(endn,#s.step)
				if s.step[n]!=nil then
					line(
					s.step[n].x,
					s.step[n].y,
					s.step[endn].x,
					s.step[endn].y,
					9+n%2)
				end
			end
			-- draw dammy target
			circfill(
				s.target.x,
				s.target.y,4,12)
		end
	end
	
	return laser
end
-->8
-- player
function player()
	local di=0.7
	local btndir,dirx,diry={
	1,2,0,3,5,6,3,4,8,7,4,0,1,2,0
	},{
	-1,1,0,0,-di,di,di,-di
	},{
	0,0,-1,1,-di,-di,di,di
	}
	btndir[0]=0
	
	local p={
		x=64,
		y=64,
		dx=0,
		dy=0,
		spd=1,
	}
	
	p.move=function()
		local dir=btndir[btn()&0b1111]
		p.dx,p.dy=0,0
		if dir>0 then
			p.dx=dirx[dir]
			p.dy=diry[dir]
			p.x+=p.dx*p.spd
			p.y+=p.dy*p.spd
			p.x=mid(0,p.x,119)
			p.y=mid(0,p.y,110)
		end
	end
	
	p.draw=function()
		circfill(p.x,p.y,4,7)
	end
		
	return p
end
-->8
-- library

--return point of curve
function curve(s,g,p,st)
	-- s:start
	-- g:goal
	-- p:control point
	-- st:step
	local x,y=
	(s.x-p.x*2+g.x)*st*st+
	(-2*s.x+2*p.x)*st+s.x,
	(s.y-p.y*2+g.y)*st*st+
	(s.y*-2+p.y*2)*st+s.y
	return {x=x,y=y}
end

function get_dist(a,b)
	--a={x,y}, b={x,y}
	return sqrt(
		(a.x-b.x)*(a.x-b.x)+
		(a.y-b.y)*(a.y-b.y)
	)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
