repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
getgenv().autocrate = true

local ws = game:GetService('Workspace')
local lp = game.Players.LocalPlayer

function touchinterest(part)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 0)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 1)
end

function autocrate()
    spawn(function () 
        while wait() do
            if not getgenv().autocrate then break end
            if workspace:FindFirstChild('Crate') then
   				touchinterest(ws.Silver)
            end
            if workspace:FindFirstChild('Golden Crate') then
   				touchinterest(ws['Golden Crate'])
            end
            if workspace:FindFirstChild('Crystal Crate') then
                touchinterest(ws.Rare)
            end
        end
    end)
end

autocrate()
