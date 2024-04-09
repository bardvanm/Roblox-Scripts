local plr = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")

local delay = 2
local songIds = {291315892, 123456789, 987654321}

local function play(id)
    local chr = plr.LocalPlayer.Character
    if not chr then
        warn("no character found.")
        return
    end
    
    local box = chr:FindFirstChild("BoomBox")
    if not box then
        warn("no boombox found.")
        return
    end
    
    local remote = box:FindFirstChild("Remote")
    if not remote then
        warn("no remote found.")
        return
    end
    
    local args = {[1] = "PlaySong", [2] = id}
    
    local success, err = pcall(function()
        remote:FireServer(unpack(args))
        print("song", id, "played successfully.")
    end)
    
    if not success then
        warn("error:", err)
    end
end

local function main()
    local index = 1
    while true do
        local id = songIds[index]
        if id then
            play(id)
            index = index + 1
            wait(delay)
        else
            index = 1
        end
    end
end

local function init()
    while not plr.LocalPlayer do
        wait()
    end
    main()
end

local function setup()
    local chr = plr.LocalPlayer.Character or plr.LocalPlayer.CharacterAdded:Wait()
    local box = chr:WaitForChild("BoomBox", 10)
    if not box then
        warn("no boombox found within 10 seconds.")
    end
end

setup()
init()