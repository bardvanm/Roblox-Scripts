local plr = game:GetService("Players")
local spawnDelay = 0.01
local spawnPosition = CFrame.new(0, 0, 0)

local function findRootPart(plr)
    return plr:FindFirstChild('HumanoidRootPart') or plr:FindFirstChild('Torso') or plr:FindFirstChild('UpperTorso')
end

local lastDeath

local function onDied()
    task.spawn(function()
        if pcall(function() return plr.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') end) then
            plr.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
                local rootPart = findRootPart(plr.LocalPlayer.Character)
                if rootPart then
                    lastDeath = rootPart.CFrame
                end
            end)
        else
            wait(plr.RespawnTime)
            onDied()
        end
    end)
end

plr.LocalPlayer.CharacterAdded:Connect(function()
    repeat wait() until findRootPart(plr.LocalPlayer.Character)
    pcall(function()
        if spawnPosition then
            wait(spawnDelay)
            findRootPart(plr.LocalPlayer.Character).CFrame = spawnPosition
        end
    end)
    onDied()
end)

onDied()