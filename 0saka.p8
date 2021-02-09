pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	palette={
		{1,3,12},
		{2,8,14}
	}
	player={x=10,y=60,s=1}
	o,r,f=ovalfill,rnd,circfill -- shorthand
	dmgtime,counter=0,0 -- time
	c,star,bullet={},{},{} -- cell,star,bullet
	raster=50
	scene=0
	destroy=0
	wait=0
	for i=1,11 do c[i]={x=0,y=0,w=0,h=0,s=0,e=0,p=0,hp=8,d=false,bomb=1,exp=0,ey=0} end
	for i=1,40 do star[i]={x=r(127),y=r(127),s=flr(r(3))+1} end
end

function _update60()

	if scene!=0 then
		if scene!=3 then counter+=1 end
		for i=1,11 do
			if c[i].w<=0 then c[i].w=flr(r(10)) c[i].s=r(1) c[i].e=r(2)-1 c[i].p=0 c[i].ey=0 end
			if c[i].h<=0 then c[i].h=flr(r(10)) end
			local v,p=(i+t())/11,{x=100,y=64}
			p={
				x=sin(t()/20)*20+100,
				y=cos(t()/20)*20+64
			}
			c[i].w-=c[i].s*0.5
			c[i].x=sin(v)*32+p.x
			c[i].y=cos(v)*48+p.y
			c[i].ey+=1
		end
		player.s=1
		if (btn(0) and player.x>=0) then player.x-=1 end
		if (btn(1) and player.x<=120) then player.x+=1 end
		if (btn(2) and player.y>=0) then player.y-=1 player.s=3 end
		if (btn(3) and player.y<=120) then player.y+=1 player.s=2 end

		if (counter%8==0 and scene==2) then
			add(bullet,{
				x=player.x+8,
				y=player.y
			})
		end
	else
		counter+=1
	end
end

function _draw()
	cls(0)
	pal(1,129,1)
	pal(3,140,1)

	if scene!=0 then
		for star in all(star) do -- background stars
			pset(star.x,star.y,star.s+4)
			star.x-=star.s
			if star.x<=0 then star.x=128 end
		end
		for i=1,11 do -- draw base
			c[i].d=false
			local x,y,w,h=c[i].x,c[i].y,c[i].w,c[i].h
			local clr1=palette[c[i].bomb][1]
			o(x-w-10,y-h-10,x+w+10,y+h+10,clr1)
			if dmgtime<=0 then
				for b in all(bullet) do
					local pt=pget(b.x+12,b.y+4)
					if (pt==1 or b.x>128) then
						c[i].d=true
						c[i].hp-=1
						sfx(3)
						del(bullet,b) break
					end
				end
			end
		end
		for i=1,11 do -- draw mid color
				local x,y,w,h,d=c[i].x,c[i].y,c[i].w,c[i].h,c[i].d
				local clr2=palette[c[i].bomb][2]
				if d==true then clr2=7 end
				o(x-w-10,y-h-10,x+w+7,y+h+7,clr2)
		end
		for i=1,11 do -- draw highlight
				local x,y,w,h,d=c[i].x,c[i].y,c[i].w,c[i].h,c[i].d
				local clr3=palette[c[i].bomb][3]
				if d==true then clr3=7 end
				o(x-w-8,y-h-8,x+w,y+h,clr3)
		end
		for i=1,11 do -- draw eye and laser
			local x,y,w,e,p,ey=c[i].x,c[i].y,c[i].w,abs(c[i].e*5),c[i].p,c[i].ey
			if e>=3.0 then
				local r=w*1.2
				f(x-e,y-e,r+1,2)
				f(x-e,y-e,r,6)
				f(x-e,y-e,r-1,7)
				f(x-e*1.1,y-e*1.1,r/2,1)
				if (c[i].hp>0 and scene==2) then
					if ey<=20 then
						f(x-e,y-e,flr(ey*0.1),14)
					else
						if c[i].p==0 then sfx(1) end
						if r>=1 then
							c[i].p+=20
							f(x-e,y-e,1,14)
							rect(x-c[i].p,y-e,x-e,y-e,14)
						end
					end
				end
			end
		end
		for i=1,11 do -- destroy
			if (c[i].bomb==1 and c[i].hp<=0) then
				sfx(4)
				c[i].exp+=0.25
				local ex=flr(c[i].exp)
				spr(5+(ex%3)*2,c[i].x+(flr(r(10)-10)),c[i].y+(flr(r(10)-10)),2,2)
				spr(5+(ex%3)*2,c[i].x+(flr(r(10)-10)),c[i].y+(flr(r(10)-10)),2,2)
				spr(5+(ex%3)*2,c[i].x+(flr(r(20)-20)),c[i].y+(flr(r(20)-20)),2,2)
				spr(5+(ex%3)*2,c[i].x+(flr(r(20)-20)),c[i].y+(flr(r(20)-20)),2,2)
				if ex>=8 then c[i].bomb=2 destroy+=1 end
			end
		end

		if dmgtime<=0 then -- show player
			px=0
			repeat
				local x=player.x+px
				py=0
				repeat
					local y=player.y+py
					local c=pget(x,y)
					if (c==11 or c==2 or c==8 or c==14) then
						dmgtime=60 break
					end
					py+=1
				until py>8
				if dmgtime!=0 then break end
				px+=1
			until px>8
			spr(player.s,player.x,player.y,1,1)
			for b in all(bullet) do
				spr(4,b.x,b.y)
				sfx(0)
				b.x+=4
				local c=pget(b.x+8,b.y+4)
				if (c==2 or c==8 or c==14 or b.x>128) then
					del(bullet,b) break
				end
			end
		else
			bullet={}
			if dmgtime>=60 then sfx(2) end
			dmgtime-=1
			for i=0,5 do
				local x,y=player.x+flr(r(8)-4),player.y+flr(r(8)-4)+4
				rect(x,y,x,y,10)
			end
			if dmgtime%4==0 then spr(player.s,player.x,player.y,1,1) end
		end

		if raster<200 then -- raster scroll
			if stat(16)==-1 then music(0) end
			memcpy(0,0x6000,128*64)
			cls()
			raster+=1
			for y=0,127 do
				local rx=ceil(sin((y/raster)*8)*(200-raster))
				sspr(0,y,128,1,rx,y,128,1)
			end
			wait=120
			reload()
		elseif scene==1 then
			if wait>0 then
				music(-1,300)
				txt("go!!",nil,60,7,1,2)
				wait-=1
			else
				scene=2
				counter=0
			end
		end

		local sec=counter/60
		if scene==2 then
			txt(flr(sec).."."..flr(sec%1*10^2),2,2,7,1,2)
			txt(" sec.",22,2,7,1,2)
		end

		if destroy>=11 then scene=3 end
		if scene==3 then
			txt("you saved the shining of lifes",nil,50,7,1,2)
			txt("in "..sec.." seconds!",nil,58,12,1,2)
			txt("- press z key or 🅾️ to restart -",nil,68,7,rnd(15),2)
			if btn(4) then
				destroy=0
				player={x=10,y=60,s=1}
				for i=1,11 do c[i]={x=0,y=0,w=0,h=0,s=0,e=0,p=0,hp=8,d=false,bomb=1,exp=0,ey=0} end
				raster=50
				scene=1
				sfx(1)
			end
		end
	else -- title screen
		local y=160-counter
		if y<=30 then
			y=30
			txt("- press z key or 🅾️ to start -",nil,60,7,rnd(15),2)
			txt("save",nil,72,6,1,2)
			txt("\"the shining of lifes\"!",nil,80,6,1,2)
			if btn(4) and wait<0 then sfx(1) wait=60 end
			wait-=1
			if wait==0 then scene=1 end
		end
		sspr(0,16,48,24,40,y)
	end
	-- print(stat(16),2,120,7)
end

function txt(t,x,y,c,b,f)
	if x==nil then x=64-#t*2 end
	if y==nil then y=60 end
	if c==nil then c=0 end
	if f==1 then print(t,x+1,y+1,1) end
	if f==2 then
		print(t,x+1,y,b)
		print(t,x-1,y,b)
		print(t,x,y+1,b)
		print(t,x,y-1,b)
		print(t,x+1,y+1,b)
		print(t,x-1,y-1,b)
	end
	print(t,x,y,c)
end
__gfx__
00000000700000007000000076000000000000000000000000000000000000000000000000000444400000000000000000000000000000000000000000000000
00000000770000006700000066600000000000000000000000000000000044000000444000444444444000000000000000000000000000000000000000000000
007007006770000057777c0056666700000000000000008440000000800444440004494004444999944444400000000000000000000000000000000000000000
0007700006676c0055667cc755556666000000000000004994000000004999944449994004994aaa994999440000000000000000000000000000000000000000
00077000855666778556666085555550dcc00dcc000004aa9948000000499799aaa999400499aa7aa99aa9940000000000000000000000000000000000000000
0070070066655660066700000667000000000000000004aa77940000004497777aaa94000449aa77a9aaa9940000000000000000000000000000000000000000
0000000005500000067000000660000000000000000449a777940000000499aa4aaa940000099a777779a9400000000000000000000000000000000000000000
0000000007000000070000000600000000000000004499a77794400000049977a94a9400044977777777aa400000000000000000000000000000000000000000
0000000000000000000000000000000000000000000849a7aaa940000049a777794aa4000499777777779a400000000000000000000000000000000000000000
0000000000000000000000000000000000000000000049aaa9994000044aa777794a9440449a7777aa779a940000000000000000000000000000000000000000
00000000000000000000000000000000000000000000049994448000049a77aa9979940049aa77777779aa940000000000000000000000000000000000000000
00000000000000000000000000000000000000000000049448000000049aaaa999794000449aa9999aaaa9940000000000000000000000000000000000000000
0000000000000000000000000000000000000000000008440000000004997994099400000449aaaaaa9999440000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000004444444494000004449aa9944444400000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004444080000044999444440000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000080000000000000000004444400000000000000000000000000000000000000000000000
00000000000000820000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000077777778200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000677777782000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000770000827000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00006700008276000000777777007777077077077770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007700082770000007777777007777077077077770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00067000820760000077700770077077077077077077000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077008207700000077700070077077077077077077000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00670082007607770007700000770077077770077007700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00770820077007700000770000770077077770077007700000000000000000000000000000000000000000000000000000000000000000000000000000000000
06708200076000007000777007700077077077077000770000000000000000000000000000000000000000000000000000000000000000000000000000000000
07782000770000007700777007777777077077077777770000000000000000000000000000000000000000000000000000000000000000000000000000000000
07827777760000077777770077000077077077077000077000000000000000000000000000000000000000000000000000000000000000000000000000000000
08277777700000077777700077000077077077077000077000000000000000000000000000000000000000000000000000000000000000000000000000000000
82000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007000707000000707000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000077777000777707777707777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007070000700700707000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007000000700700007000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007777000777700770007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100003603034030310202d020280101e0100d000000000500003000230001f000000001900017000000001300013000000001200000000160000000000000000002000000000250002b000000003100034000
00010000202303f230232303f230262303f2302a2303e230302303f230382303c2303e2303f2303f2303f2303f2303f2303f2203f2203f2203f2203f2203f2203f2203f2103f2103f2103e2003e2003e2003e200
000200001d430344303f43030430254301d4301843014420114200e4200b420084200642005420054200441003410034100241001410004100041000400004000040000400004000040000400004000040000400
000100000d060290402e0402903016030130203002039020360202902017020040200002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001f6701d6701b67019670146700d6700b6701e6701d6701b6701a670166700d67008670196701767015670136700f670176701567012660106600d6600a65012650106400c6400b630046300262000600
000100200b1401114015140171401814016140101400c1400a1400c1401014015140181401a1401b1401b14018140121400e1400c1400c14010140171401a1401d1401c1401a14016140121400e1400a14009140
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 05424344
00 06424344
