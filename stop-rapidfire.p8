pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--stop the rapid-fire
function _init()
	fire=false
	release=true
	p=0
end

function _update60()
	if btn(4) then
		if release then
			fire=true
			release=false
		else
			fire=false
		end
	end
	if not btn(4)
	and not release then
		release=true
		fire=false
	end
	
	if fire then 
		p+=1
	end
end


function _draw()
	cls()
	--show values
	print("press z",2,2,6)
	print(
	"fire:"..(fire and "true" or "false"),
	2,10,8)
	print(
	"release:"..(release and "true" or "false"),
	2,18,7)
	print("p:"..p,2,26,14)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000