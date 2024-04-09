repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

getgenv().autojunglechest = false
getgenv().automoai = false
getgenv().autocatch = false
getgenv().autofarmzone = false
getgenv().autofarmzonecatch = false
getgenv().autofarmzonedelete = false
getgenv().autobuy = false

local remote = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local player = game.Players.LocalPlayer

local zones = workspace.Map.Areas:GetChildren()

local function startauto(taskname, enemyname)
    spawn(function()
        local remotefired = false
        while wait() do
            if not getgenv()[taskname] then break end
            if workspace.Enemies:FindFirstChild(enemyname) and not remotefired then
                remote.Functions.Combat.SendFighters:FireServer(enemyname)
                remotefired = true
            elseif not workspace.Enemies:FindFirstChild(enemyname) then
                remotefired = false
            end
        end
    end)
end

local function startfarmzone(zone, killtime)
    spawn(function()
        while wait() do
            if not getgenv().autofarmzone then break end
            for i, v in pairs(game:GetService("Workspace").Map.Areas[zone].Spots:GetChildren()) do
                if v.Name ~= "Empty" then
                    player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Areas[zone].Spots[tostring(v)].CFrame
                    wait(0.2)
                    remote.Functions.Combat.SendFighters:FireServer(tostring(v))
                    if getgenv().autofarmzonecatch then
                        spawn(function()
                            local args = {
                                [1] = "Basic",
                                [2] = tostring(v)
                            }
                            for i = 1, 20 do
                                remote.Functions.Combat.UseCapsule:InvokeServer(unpack(args))
                                wait(0.001)
                            end
                        end)
                    end
                    if getgenv().autofarmzonedelete then
                        local data = remote.Functions.Core.GetData:InvokeServer()
                        for hex, pet in pairs(data.Pets) do
                            if pet.Name ~= "Sand Golem" and pet.Name ~= "Orc" and pet.Name ~= "Blob" then
                                remote.Functions.Pets.Delete:FireServer(hex)
                            end
                        end
                    end
                    wait(killtime)
                end
            end
        end
    end)
end

local function startbuycapsule(capsule, interval)
    spawn(function()
        while wait() do
            if not getgenv().autobuy then break end
            remote.Functions.Progress.BuyCapsule:FireServer(capsule)
            wait(interval)
        end
    end)
end

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()

local w = library:CreateWindow("barts Legacy")
local farming = w:CreateFolder("farming")
local constants = w:CreateFolder("constants")
local teleports = w:CreateFolder("teleports")
local misc = w:CreateFolder("misc")

farming:Toggle("moai", function(bool)
    getgenv().automoai = bool
    if bool then
        startauto("automoai", "Moai")
    end
end)

farming:Toggle("jungle chest", function(bool)
    getgenv().autojunglechest = bool
    if bool then
        startauto("autojunglechest", "JungleChest")
    end
end)

local selectedzone
farming:Dropdown("select zone to farm", {"forest", "beach", "desert", "cavern", "jungle", "easter", "volcano", "winter"}, true, function(value)
    selectedzone = value
    startfarmzone(selectedzone)
end)

local timetokill = 1
farming:Slider("time to kill", {
    min = 1,
    max = 10,
    precise = false
}, function(value)
    timetokill = value
end)

farming:Toggle("farm zone", function(bool)
    getgenv().autofarmzone = bool
    if bool and selectedzone then
        startfarmzone(selectedzone, timetokill)
    end
end)

farming:Toggle("catch pets", function(bool)
    getgenv().autofarmzonecatch = bool
end)

farming:Toggle("delete pets", function(bool)
    getgenv().autofarmzonedelete = bool
end)

local selectedcapsule
farming:Dropdown("select capsule to buy", {"basic", "pro", "mythic"}, true, function(value)
    selectedcapsule = value
end)

local buycapsuleinterval = 1
farming:Slider("delay capsule", {
    min = 1,
    max = 10,
    precise = true
}, function(value)
    buycapsuleinterval = value
end)

farming:Toggle("buy capsule", function(bool)
    getgenv().autobuy = bool
    if bool and selectedcapsule then
        startbuycapsule(selectedcapsule, buycapsuleinterval)
    end
end)

constants:Button("100% catch rate", function()
    local petmodule = require(remote.PetModule)
    petmodule.getchance = function() return 1 end
end)

constants:Button("gold merge cost", function()
    local petmodule = require(remote.PetModule)
    setconstant(petmodule.mergecost, 2, 1)
end)

constants:Button("buy all areas", function()
    for i = 2, 20 do
        remote.Functions.Areas.BuyArea:FireServer(i)
        wait(1)
    end
end)

teleports:Button("moai", function()
    teleportto(1717, 50, 451)
end)

teleports:Button("jungle chest", function()
    teleportto(-1246, -42, 2434)
end)

misc:DestroyGui()
