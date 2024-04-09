if not game:IsLoaded() then
    game.Loaded:Wait()
end

print("initializing.")
getgenv().autojunglechest = true;

function antiafk()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

local remotefired = false
function startjunglechestbot()
    while wait(1) do
        if not autojunglechest then break end
        if game:GetService("Workspace").Enemies:FindFirstChild("JungleChest") and not remotefired then
            game:GetService("ReplicatedStorage").Functions.Combat.SendFighters:FireServer("JungleChest")
            remotefired = true
        elseif not game:GetService("Workspace").Enemies:FindFirstChild("JungleChest") then
            remotefired = false
        end
    end
end

local function teleportandstart()
    repeat
        wait()
    until game:IsLoaded() and game.Players.LocalPlayer.Character

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1247, -46, 2433) 
    antiafk()
    print("========================")
    print("jungle chest bot loaded!")
    print("========================")
    startjunglechestbot()
end

teleportandstart()

-- dynamic wait
local dynamicwait = 20
while dynamicwait > 0 do
    wait(1)
    dynamicwait = dynamicwait - 1
end

-- later execution
antiafk()
getgenv().autojunglechest = true;
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1247, -46, 2433) 
local remotefired = false
function startjunglechestbot()
    while wait(1) do
        if not autojunglechest then break end
        if game:GetService("Workspace").Enemies:FindFirstChild("JungleChest") and not remotefired then
            game:GetService("ReplicatedStorage").Functions.Combat.SendFighters:FireServer("JungleChest")
            remotefired = true
        elseif not game:GetService("Workspace").Enemies:FindFirstChild("JungleChest") then
            remotefired = false
        end
    end
end
startjunglechestbot()
