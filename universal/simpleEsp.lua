local plr = game:GetService("Players")

local function createEsp(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")
    
    local billboardgui = Instance.new("BillboardGui")
    billboardgui.Name = "PlayerESP"
    billboardgui.Size = UDim2.new(0, 100, 0, 50)
    billboardgui.StudsOffset = Vector3.new(0, 3, 0)
    billboardgui.AlwaysOnTop = true

    local namelabel = Instance.new("TextLabel")
    namelabel.Text = player.Name
    namelabel.Size = UDim2.new(1, 0, 1, 0)
    namelabel.TextScaled = true
    namelabel.TextColor3 = Color3.new(1, 0, 0)
    namelabel.BackgroundTransparency = 1
    namelabel.BorderSizePixel = 0
    namelabel.Font = Enum.Font.SourceSansBold
    namelabel.Parent = billboardgui

    billboardgui.Parent = head
    
    local torso = character:WaitForChild("Torso") or character:WaitForChild("UpperTorso")
    local hrp = character:WaitForChild("HumanoidRootPart")
    local hrppos, torsopos = hrp.Position, torso.Position
    local size = (torsopos - head.Position).Magnitude * Vector3.new(0.5, 1.5, 0)
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "PlayerESP_Box"
    box.Size = size
    box.Color3 = Color3.new(1, 0, 0)
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.Adornee = torso
    box.ZIndex = 5
    box.Parent = torso
    
    local cylinder = Instance.new("CylinderHandleAdornment")
    cylinder.Name = "PlayerESP_Cylinder"
    cylinder.Height = (torsopos - head.Position).Magnitude
    cylinder.Radius = (torso.Size.X + torso.Size.Z) / 4
    cylinder.Color3 = Color3.new(0, 1, 0)
    cylinder.Transparency = 0.5
    cylinder.AlwaysOnTop = true
    cylinder.Adornee = torso
    cylinder.ZIndex = 5
    cylinder.Parent = torso
    
    local sphere = Instance.new("SphereHandleAdornment")
    sphere.Name = "PlayerESP_Sphere"
    sphere.Radius = (torso.Size.X + torso.Size.Y + torso.Size.Z) / 6
    sphere.Color3 = Color3.new(0, 0, 1)
    sphere.Transparency = 0.5
    sphere.AlwaysOnTop = true
    sphere.Adornee = head
    sphere.ZIndex = 5
    sphere.Parent = head
end

plr.PlayerAdded:Connect(function(player)
    createEsp(player)
end)

for _, player in ipairs(plr:GetPlayers()) do
    createEsp(player)
end
