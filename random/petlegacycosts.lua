-- leakz
local PetsMod = require(game:GetService("ReplicatedStorage").Items.Pets)

print("--UPVALUES--")
for i,v in pairs(getupvalues(PetsMod.setStats)) do
	print(i,v);
end

print("---")
print("--CONSTANTS--")
for i,v in pairs(getconstants(PetsMod.setStats)) do
	print(i,v);
end

setconstant(PetModule.mergeCost, 2, 60)

local v1 = {};
local v2 = require(script.Parent.Areas);
function setStats(p1, p2)
	p1.Damage = p2 * p1.Rarity * 10;
	p1.MaxHealth = 50 * p2 * p1.Rarity;
end;
for v3, v4 in pairs(script:GetChildren()) do
	local v5, v6, v7 = pairs(require(v4));
	while true do
		local v8, v9 = v5(v6, v7);
		if not v8 then
			break;
		end;
		if not v9.MaxHealth then
			setStats(v9, tonumber(v4.Name));
		end;
		local v10 = tonumber(v4.Name) or v4.Name;
		if v2[v10] then
			v9.World = v2[v10].World;
		end;
		v9.Area = v10;
		v1[v8] = v9;	
	end;
end;
return v1;
