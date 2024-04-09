repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local autoflags = {
    crate = false,
    skip = false,
    boss = false,
    rebirth = false
}

local cratedata = {
    {"crate", 1},
    {"golden crate", 1.5},
    {"crystal crate", 2},
    {"diamond crate", 2.5}
}

local cratedelay = 1
local rebirthdelay = 1
local skipdelay = 1

local rs = game:GetService('ReplicatedStorage')
local ws = game:GetService('Workspace')
local lp = game.Players.LocalPlayer

function touchinterest(part)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 0)
    firetouchinterest(lp.Character.HumanoidRootPart, part, 1)
end

local function spawnaction(actionfunction, indicator)
    spawn(function () 
        while autoflags[actionfunction] do
            local success, error = pcall(actionfunction)
            if not success then
                warn("Error in action:", error)
            end
            wait(1)
        end
        indicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end)
end

local function touchcrate(crate, delay)
    local part = ws:FindFirstChild(crate)
    if part then
        touchinterest(part)
        wait(delay)
    end
end

function autocrate()
    for _, crate in ipairs(cratedata) do
        touchcrate(crate[1], crate[2])
    end
end

function autoskip()
    local success, error = pcall(function()
        rs.Events.StageController:FireServer("start")
    end)
    if not success then
        warn("Error skipping:", error)
    end
    wait(skipdelay)
end

function autoboss()
    local success, error = pcall(function()
        rs.Events.StageController:FireServer("cancel")
    end)
    if not success then
        warn("Error canceling boss:", error)
    end
end

function autorebirth()
    local success, error = pcall(function()
        local function getnil(name,class) for _,v in next, getnilinstances() do if v.ClassName==class and v.Name==name then return v;end end end

        local args = {
            [1] = "rebirth",
            [2] = getnil("inputobject", "inputobject")
        }

        rs:WaitForChild("events"):WaitForChild("basehandler"):InvokeServer(unpack(args))
    end)
    if not success then
        warn("Error rebirthing:", error)
    end
end

local function createActionToggle(actionName, actionFunction, delay, folder)
    local indicator = folder:label(actionName, 'Off')
    folder:toggle(actionName, function(bool)
        autoflags[actionName] = bool
        setIndicatorColor(indicator, bool)
        if bool then 
            spawnaction(actionFunction, indicator)
        end
    end)
    folder:slider(actionName..' delay', {min = 0.5, max = 3}, function(value)
        delay = value
    end)
end

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:CreateWindow('defend.')
local auto = w:CreateFolder('automatic')
local misc = w:CreateFolder('miscellaneous')

createActionToggle('crate', autocrate, cratedelay, auto)
createActionToggle('rebirth', autorebirth, rebirthdelay, auto)
createActionToggle('boss', autoboss, 0, auto)
createActionToggle('skip', autoskip, skipdelay, auto)

misc:button('reset all actions', function()
    for action, _ in pairs(autoflags) do
        autoflags[action] = false
    end
    for _, indicator in pairs(auto:GetChildren()) do
        if indicator:IsA("Frame") then
            setIndicatorColor(indicator, false)
        end
    end
end)

misc:destroygui()
