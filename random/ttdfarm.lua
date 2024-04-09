repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
game:GetService('Workspace').Decoration:Destroy()
local plr = game.Players.LocalPlayer
local char = plr.Character
local cam = game.Workspace.CurrentCamera

if char and char:FindFirstChild("HumanoidRootPart") then
    local charPos = char:FindFirstChild("HumanoidRootPart").Position
    cam.CFrame = CFrame.new(charPos + Vector3.new(0, 10, 0), charPos)
    cam.FieldOfView = 30
end

if plr then
    local targetPos = Vector3.new(61, 17, 98)
    plr.Character:MoveTo(targetPos)
end
