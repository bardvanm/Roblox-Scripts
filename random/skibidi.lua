repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

getgenv().autoSummon = false
getgenv().autoSkip = false
getgenv().autoVote = false
getgenv().autoJoin = false

local ws = game:GetService('Workspace')
local lp = game.Players.LocalPlayer

function touchInterest(part)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 0)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 1)
end

function teleportTo(x, y, z)
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
end

function autoSummon()
    spawn(function()
        while wait() do

        end
    end)
end

function autoSkip()
    spawn(function()
        while wait() do
            if not getgenv().autoSkip then break end
            local args = {
                [1] = {
                    [1] = {
                        [1] = "\180\162"
                    }
                }
            }
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
        end
    end)
end

function autoBoss()
    spawn(function()
        while wait(1.2) do
            if not getgenv().autoBoss then break end
            game:GetService("ReplicatedStorage").Events.StageController:FireServer("Cancel")
        end
    end)
end

function autoRebirth()
    spawn(function()
        while wait() do
            if not getgenv().autoRebirth then break end
            function getNil(name, class)
                for _, v in next, getnilinstances() do
                    if v.ClassName == class and v.Name == name then
                        return v
                    end
                end
            end
            local args = {
                [1] = "Rebirth",
                [2] = getNil("InputObject", "InputObject")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BaseHandler"):InvokeServer(unpack(args))
        end
    end)
end

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:CreateWindow('🚽🚽🚽')
local auto = w:CreateFolder('Automatic')
local misc = w:CreateFolder('Miscellaneous')

auto:Toggle('Auto Summon', function(bool)
    getgenv().autoCrate = bool
    if bool then
        autoCrate()
    end
end)

auto:Toggle('Auto Skip', function(bool)
    getgenv().autoSkip = bool
    if bool then
        autoSkip()
    end
end)

auto:Toggle('Auto Rebirth', function(bool)
    getgenv().autoRebirth = bool
    if bool then
        autoRebirth()
    end
end)

misc:Button('Destroy Decorations', function()
    ws.Decoration:Destroy
end)

misc:DestroyGui()
