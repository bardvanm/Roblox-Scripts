repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
end

getgenv().autojunglechest = true

local function startjunglechestbot()
    local jungleChest = game:GetService("Workspace").Enemies:FindFirstChild("JungleChest")
    local lastCheck = os.time()
    while true do
        if not autojunglechest then break end
        if jungleChest then
            local currentTime = os.time()
            if currentTime - lastCheck >= 1 then
                game:GetService("ReplicatedStorage").Functions.Combat.SendFighters:FireServer("JungleChest")
                lastCheck = currentTime
            end
        end
        wait()
    end
end

local function teleportAndStart()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    repeat wait() until game:IsLoaded() and character:FindFirstChild("HumanoidRootPart")

    character.HumanoidRootPart.CFrame = CFrame.new(-1247, -46, 2433) 
    antiafk()
    print("========================")
    print("jungle chest bot loaded!")
    print("========================")
    startjunglechestbot()
end

teleportAndStart()

getgenv().autojunglechest = true
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1247, -46, 2433) 
local function startjunglechestbot()
    local jungleChest = game:GetService("Workspace").Enemies:FindFirstChild("JungleChest")
    local lastCheck = os.time()
    while true do
        if not autojunglechest then break end
        if jungleChest then
            local currentTime = os.time()
            if currentTime - lastCheck >= 1 then
                game:GetService("ReplicatedStorage").Functions.Combat.SendFighters:FireServer("JungleChest")
                lastCheck = currentTime
            end
        end
        wait()
    end
end
startjunglechestbot()
