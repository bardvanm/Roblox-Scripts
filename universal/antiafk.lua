local function antiafk()
    local vu = game:GetService("VirtualUser")
    local plr = game:GetService("Players")
    local cameraCFrame = workspace.CurrentCamera.CFrame

    plr.LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new(0,0), cameraCFrame)
        vu:ReleaseController()
        vu:Button2Down(Vector2.new(0,0), cameraCFrame)
        vu:Button2Up(Vector2.new(0,0), cameraCFrame)
    end)
end
antiafk()
