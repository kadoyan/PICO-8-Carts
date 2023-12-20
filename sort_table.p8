pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function bubble_sort(tbl,key)
	local n=#tbl
	for i=1,n-1 do
		for j=1,n-i do
			if tbl[j][key]>tbl[j+1][key]
			then
				tbl[j],tbl[j+1]=
				tbl[j+1],tbl[j]
			end
		end
	end
end

cls()
local tables = {
	{x = 10, y = 20}, 
	{x = 5, y = 30}, 
	{x = 20, y = 10}
}


bubble_sort(tables, "y")
print("sorted by y:")
for _, v in ipairs(tables) do
print("x: " .. v.x .. ", y: " .. v.y)
end

bubble_sort(tables, "x")
print("sorted by x:")
for _, v in ipairs(tables) do
print("x: " .. v.x .. ", y: " .. v.y)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000