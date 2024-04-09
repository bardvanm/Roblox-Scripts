repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

getgenv().autowins = true

local ws = game:GetService('Workspace')
local lp = game.Players.LocalPlayer

function touchinterest(part)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 0)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 1)
end

function autowins()
    spawn(function () 
        while wait() do
            if not getgenv().autowins then break end
            for i=1,100 do
                touchinterest(ws.LoadedWorld.Track.Stage1K.Sign)
            end
        end
    end)
end

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:CreateWindow('race clicker')
local f = w:CreateFolder('farming')

f:Toggle('auto wins',function(bool)
    getgenv().autowins = bool
    if bool then 
        autowins()
    end
end)