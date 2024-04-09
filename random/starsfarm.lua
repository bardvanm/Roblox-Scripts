local ws = game:GetService("Workspace")
local plr = game:GetService("Players")
local lp = plr.LocalPlayer
local chr = lp.Character

if ws.Teleporters then
    ws.Teleporters:Destroy()
end

getgenv().autoDunk = true

local function autoDunker()
    while autoDunk do
        chr.Humanoid.WalkSpeed = 100
        repeat until chr.HumanoidRootPart.Position == ws.BlueGoal1.Score.Position + Vector3.new(100, -10, 0)
        chr.HumanoidRootPart.CFrame = CFrame.new(ws.BlueGoal1.Score.Position + Vector3.new(100, -10, 0))
        chr.Ball.ServerEvent:FireServer("Accuracy", 1)
        chr.Ball.ServerEvent:FireServer("Start")
        for i = 1, 10 do
            repeat until chr.HumanoidRootPart.Position == ws.BlueGoal1.Score.Position + Vector3.new(0, -1, 0)
            chr.HumanoidRootPart.CFrame = CFrame.new(ws.BlueGoal1.Score.Position + Vector3.new(0, -1, 0))
        end
    end
end

autoDunker()
