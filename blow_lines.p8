pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()
	t=0
	blow={}
end

function _update60()
	t+=1
end

function _draw()
	cls()
	blowing(40,20,80,100)
end
-->8
function blowing(x1,y1,x2,y2)
	add(blow,{
		x=x1+rnd(x2-x1),
		y=y1+rnd(y2-y1),
		l=rnd(50)+20
	})
	for b in all(blow) do
		b.y-=3
		b.l-=4
		local x,y,l=b.x,b.y,b.l
		line(x,y,x,y+l,7)
		if y+l<y then
			del(blow,b)
		end
	end
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
