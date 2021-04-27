pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--bezier curve

function fr(n)--rundom integer
	return flr(rnd(n))
end

function reset()--make points
	s={--start point
		x=fr(20)+10,
		y=110
	}
	g={--goal point
		x=s.x+fr(50)+50,
		y=fr(50)+60
	}
	p={--control point
		x=abs(s.x-g.x)*0.5,
		y=g.y-fr(50)-50
	}
	t=0--timer
	r={}--result point
end

function _init()
	reset()
end

--return point of curve
function curve(s,g,p)
	local x,y=
	(s.x-p.x*2+g.x)*t*t+
	(-2*s.x+2*p.x)*t+s.x,
	(s.y-p.y*2+g.y)*t*t+
	(s.y*-2+p.y*2)*t+s.y
	return {x=x,y=y}
end

function _update()
	r=curve(s,g,p)
	t+=0.02
	
	if r.y>128 then
		reset()
	end
end

function _draw()
	cls()
	circfill(s.x,s.y,4,8)
	print("s",s.x-1,s.y-2,7)
	circfill(p.x,p.y,1,1)
	circfill(g.x,g.y,4,12)
	print("g",g.x-1,g.y-2,7)
	circfill(r.x,r.y,2,7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
