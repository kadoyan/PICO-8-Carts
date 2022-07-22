pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
	reset()
end

function _update60()
	move_punch(pl)
	move_arm()
	plmove(pl)
end

function _draw()
	cls()
	circfill(shld.x,shld.y,2,8)
	circfill(pl.x,pl.y,1,12)
	--pset(c.x,c.y,7)
	for a in all(arms) do
		circfill(a.x,a.y,2,9)
	end
	circfill(fist.x,fist.y,4,10)
end
-->8
plmove = function(p)
	if btn(0) and p.x>0 then
		p.x-=p.spd
	end	
	if btn(1) and p.x<127 then
		p.x+=p.spd
	end
	if btn(2) and p.y>0 then
		p.y-=p.spd
	end	
	if btn(3) and p.y<127 then
		p.y+=p.spd
	end
	if btn(4) then
		fist.punch=true
	end
end

function fr(n)--rundom integer
	return flr(rnd(n))
end

function reset() 
	pl={
		x=50,y=60,spd=1
	}
	init_punch()
	r={}--result point
end
-->8
--punch
init_punch = function()
	arms={}
	for i=1,7 do
		add(arms,{x=0,y=0})
	end
	shld={--shoulder
		x=60,
		y=60
	}
	fist={
		x=shld.x,
		y=shld.y,
		punch=false
	}
	c={--control point
		x=abs(shld.x-pl.x)*0.5,
		y=pl.y-fr(50)-50
	}
end

move_punch = function(t)
	if fist.punch then
		fist.x=fist.x
			+(t.x-fist.x)*0.5
		fist.y=fist.y
			+(t.y-fist.y)*0.5
		if abs(fist.x-t.x)<=1
		and abs(fist.y-t.y)<=1
		then
			fist.punch=false
		end
	else
		fist.x=fist.x
			+(shld.x-fist.x)*0.1
		fist.y=fist.y
			+(shld.y-fist.y)*0.1
	end
end

move_arm = function()
	local subx=(shld.x-fist.x)
	c.x=fist.x+subx*.5
	c.y=fist.y+(shld.y-fist.y)*.5
	-sin(0.25
		-min(0.25,(abs(subx)*.01)%1)
	)*30
	for i=1,#arms do
		local xy=
			curve(shld,fist,c,i*0.13)
		arms[i].x=xy.x
		arms[i].y=xy.y
	end
end

--return point of curve
function curve(s,g,p,t)
	local x,y=
	(s.x-p.x*2+g.x)*t*t+
	(-2*s.x+2*p.x)*t+s.x,
	(s.y-p.y*2+g.y)*t*t+
	(s.y*-2+p.y*2)*t+s.y
	return {x=x,y=y}
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
