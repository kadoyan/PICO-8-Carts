pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	t=0
	pl={x=60,y=60,move=false}
	mp={
		{
			x=pl.x,--current x
			y=pl.y,--current y
		},
		{x=pl.x,y=pl.y}
	}
	pos={}
	for i=1,29 do
		add(pos,{
			x=pl.x,--current x
			y=pl.y,--current y
		})
	end
end

function _update()
	t+=1
	pl.move=false
	if btn(0) and pl.x>0 then
		pl.x-=2
		pl.move=true
	end
	if btn(1) and pl.x<120 then
		pl.x+=2
		pl.move=true
	end
	if btn(2) and pl.y>0 then
		pl.y-=2
		pl.move=true
	end
	if btn(3) and pl.y<120 then
		pl.y+=2
		pl.move=true
	end
	
	if pl.move then
		add(pos,{
			x=pl.x,y=pl.y
		})
		if #pos>10*(#mp+1) then
			del(pos,pos[1])
		end
		for i=1,#mp do
			if #pos>=10*(#mp+1) then
				mp[i].x=pos[10*i].x
				mp[i].y=pos[10*i].y
			end
		end
	end
end

function _draw()
	cls()
	for m in all(mp) do
		circfill(m.x,m.y,3,12)
	end
	rectfill(pl.x,pl.y,pl.x+8,pl.y+8,7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000