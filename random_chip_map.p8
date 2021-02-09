pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	m,hr,mx,my,w,h,sp={},{},0,0,258,258,1
	for y=0,h do
		for x=0,w do
			local c=sub(tostr(flr(rnd(16)-1),true),5,6)
			printh(tostr(c))
			add(hr,c)
		end
		add(m,hr)
		hr={}
	end
end

function _update60()
	if btn(0) then mx-=sp end
	if btn(1) then mx+=sp end
	if btn(2) then my-=sp end
	if btn(3) then my+=sp end
	if mx<0 then mx=0 end
	if my<0 then my=0 end
	if mx>(w-17)*8 then mx=(w-17)*8 end
	if my>(h-17)*8 then my=(h-17)*8 end
end

function _draw()
	cls(0)
	local sx,sy,gx,gy=mx%8,my%8,flr(mx/8),flr(my/8)
	local x,y=0,0
	for y=1,18 do
		for x=1,18 do
			local c=m[x+gx][y+gy]
			rectfill((x-2)*8-sx,(y-2)*8-sy,(x-1)*8-sx,(y-1)*8-sy,tonum("0x"..c))
			-- print(c,(x-1)*8,(y-1)*8,7)
		end
	end
	rectfill(1,120,126,126,0)
	print("x:"..tostr(mx).."/y:"..tostr(my).."/mx:"..tostr(gx).."/my:"..tostr(gy),2,121,7)
	print("memory:"..tostr(flr(stat(0)/2048*100)).."%/x:"..mx.."/y:"..my,2,2,7)
end


