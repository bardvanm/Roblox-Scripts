-- hope you can fix this script :D

repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
local autostats = false
local autodunk = false
local autoupgrade = false
local autoballs = false
local autojerseys = false
local autoshoes = false
local autorebirth = false
local autocontest = false

local lp = game.Players.LocalPlayer
local ws = game:GetService('Workspace')
local rs = game:GetService("ReplicatedStorage")
local serverEvent = rs.ServerEvent

local balls = {'Default', 'Allstar', 'Grass', 'Tennis', 'Moon', 'Magma', 'Water', 'Fire', 'White Fire', 'Black Fire', 'Blue Fire', 'Galaxy', 'Blue Orb', 'White Orb', 'Black Orb', 'Ruby Orb', 'Gold', 'Amethyst', 'Gloomy', 'Fire & Ice'}
local jerseys = {'Default', 'Classic', 'Abstract', 'Hearts', 'Sprinkles', 'Checkerboard', 'Floral', 'Jacko', 'Snowflakes', 'Allstar', 'Sapphire', 'Emerald', 'Ruby', 'Diamond', 'Galaxy', 'Gold', 'Amethyst', 'Gloomy', 'Fire & Ice'}
local shoes = {'Default', 'Basketball', 'Cow', 'Cloudy', 'Smiley', 'Santa', 'Pink Camo', 'Magma', 'Minecraft', 'Money', 'Lightning', 'Allstar', 'Sapphire', 'Emerald', 'Ruby', 'Diamond', 'Galaxy', 'Gold', 'Amethyst', 'Gloomy', 'Fire & Ice'}

local autodunkdistance = 10

local function getroot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local function touchinterest(part)
    firetouchinterest(game:GetService("Workspace").bartvanm.Ball, part, 0)
    firetouchinterest(game:GetService("Workspace").bartvanm.Ball, part, 1)
end

local function getaccuracy()
    local accuracy = lp.leaderstats.Rebirths.Value * 15 + rs.Items.Jerseys[rs.Players.bartvanm.Equipped.Jerseys.Value].Accuracy.Value + rs.Items.Shoes[rs.Players.bartvanm.Equipped.Shoes.Value].Accuracy.Value
    return accuracy
end

local function calculatedistance(accuracy)
    local distance = accuracy/4
    return distance
end

local function fly()
	local T = getroot(lp.Character)
	local SPEED = 0
	local function fly()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if lp.Character:FindFirstChildOfClass('Humanoid') then
					lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
                SPEED = 0
                BV.velocity = Vector3.new(0, 0, 0)
			until not FLYING
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if lp.Character:FindFirstChildOfClass('Humanoid') then
				lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
end

local function nofly()
	FLYING = false
	if flykeydown or flykeyup then flykeydown:Disconnect() flykeyup:Disconnect() end
	if lp.Character:FindFirstChildOfClass('Humanoid') then
		lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
end

local function autodunk()
    spawn(function () 
        while wait() do
            if not autodunk then lp.Character.HumanoidRootPart.Anchored = false break end
            lp.Character.HumanoidRootPart.Anchored = false    
            lp.Character.HumanoidRootPart.CFrame = ws.BlueGoal1.Score.CFrame + Vector3.new(autodunkdistance,0,0)
            lp.Character.Ball.ServerEvent:FireServer('Accuracy', 1)
            lp.Character.Ball.ServerEvent:FireServer('Start')
            for i=1,100 do
                touchinterest(ws.BlueGoal1.Score)
            end
            wait(0.01)
        end
    end)
end

local function autoupgrade()
    spawn(function () 
        while wait() do
            if not autoupgrade then break end
            serverEvent:FireServer('Dunk')
        end
    end)
end

local function autoballs()
    spawn(function () 
        while wait() do
            if not autoballs then break end
            for i, v in pairs(balls) do
                serverEvent:FireServer('Buy', 'Balls', v)
                serverEvent:FireServer('Equip', 'Balls', 'Fire & Ice')
                wait(0.1)
            end
        end
    end)
end

local function autojerseys()
    spawn(function () 
        while wait() do
            if not autojerseys then break end
            for i, v in pairs(jerseys) do
                serverEvent:FireServer('Buy', 'Jerseys', v)
                wait(0.1)
            end
        end
    end)
end

local function autoshoes()
    spawn(function () 
        while wait() do
            if not autoshoes then break end
            for i, v in pairs(balls) do
                serverEvent:FireServer('Buy', 'Shoes', v)
                wait(0.1)
            end
        end
    end)
end

local function autorebirth()
    spawn(function () 
        while wait() do
            if not autorebirth then break end
            serverEvent:FireServer('Rebirth')
        end
    end)
end

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow('DUNKING MEISTER') 
local s = w:CreateFolder('Statistics😽')
local f = w:CreateFolder('Farm👨‍🌾')
local m = w:CreateFolder('Player🙉')
local d = w:CreateFolder('Demolish💥') 

s:Toggle('auto stats',function(bool)
    autostats = bool
    if bool then 
        autostats()
    end
end)

f:Toggle('auto dunk',function(bool)
    autodunk = bool
    if bool then 
        autodunk()
    end
end)

f:Slider('auto dunk distance',{
    min = 10,
    max = 10000,
    precise = false
},function(value)
    autodunkdistance = value 
end)

f:Toggle('auto upgrade',function(bool)
    autoupgrade = bool
    if bool then 
        autoupgrade()
    end
end)

f:Toggle('auto balls',function(bool)
    autoballs = bool
    if bool then 
        autoballs()
    end
end)

f:Toggle('auto jerseys',function(bool)
    autojerseys = bool
    if bool then 
        autojerseys()
    end
end)

f:Toggle('auto shoes',function(bool)
    autoshoes = bool
    if bool then 
        autoshoes()
    end
end)

f:Toggle('auto rebirth',function(bool)
    autorebirth = bool
    if bool then 
        autorebirth()
    end
end)

m:Button('fly',function()
    fly()
end)

m:Button('nofly',function()
    nofly()
end)

d:Button('teleporters',function()
    if ws.Teleporters then ws.Teleporters:Destroy() end
end)
