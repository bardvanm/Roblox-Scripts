repeat wait() until game:isloaded() and game.players and game.players.localplayer and game.players.localplayer.character

-- Booleans
getgenv().autoplant = false
getgenv().autoharvest = false
getgenv().autosell = false
getgenv().autobuy = false
getgenv().autocatch = false

-- Paths
local replicatedstorage = game:getservice('replicatedstorage')
local workspace = game:getservice('workspace')

local localplayer = game.players.localplayer

local foods = {'bacon', 'pizza', 'watermelon', 'hotdog', 'pie', 'cookie', 'pancakes', 'donut', 'ice cream', 'sugar cookie', 'turkey leg', 'cake', 'burger'}

local function touchinterest(part)
    firetouchinterest(localplayer.character.humanoidrootpart, part, 0)
    firetouchinterest(localplayer.character.humanoidrootpart, part, 1)
end

local function teleportto(x, y, z)
    localplayer.character.humanoidrootpart.cframe = cframe.new(x, y, z)
end

local function invokeserverwithdelay(service, functionname, arguments, delay)
    spawn(function()
        wait(delay)
        replicatedstorage.relay.blocks[service][functionname]:invokeserver(unpack(arguments))
    end)
end

local function sellall()
    spawn(function()
        for i = 1, 30 do
            replicatedstorage.relay.inventory.storeitems:invokeserver(i + 9, "backpack", "sell", 99)
        end
        replicatedstorage.relay.inventory.sellitems:invokeserver()
    end)
end

local function autoharvest()
    spawn(function () 
        while wait() do
            if not getgenv().autoharvest then break end
            replicatedstorage.eat:fireserver()
        end
    end)
end

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
local window = library:createwindow('farmstead')

local auto = window:createfolder('automatic')
local farming = window:createfolder('farming')
local shop = window:createfolder('shop')

auto:toggle('auto collect mushrooms', function(enabled)
    getgenv().autoharvest = enabled
    if enabled then 
        autoharvest()
    end
end)

farming:button('harvest cranberry', function()
    for i = 1, 75 do
        invokeserverwithdelay("harvestcrop", "invokeserver", {vector3.new(-21 + i, 70, 84)}, 5)
    end
end)

farming:button('clear all grass', function()
    for i = 1, 200 do
        for j = 0, 5 do
            invokeserverwithdelay("harvestcrop", "invokeserver", {vector3.new(130 - i, -10, 200), 1}, 1)
        end
    end
end)

farming:button('collect mushrooms', function()
    spawn(function()
        for i = 1, 500 do
            sellall()
            wait(5)
        end
    end)
    for i = 1, 100 do
        for j = 1, 3 do
            invokeserverwithdelay("harvestcrop", "invokeserver", {vector3.new(-37 - i, -10, 97), j}, 1)
        end
    end
end)

shop:button('sell all', sellall)

shop:button('buy cranberries', function()
    for i = 1, 10 do
        replicatedstorage.relay.market.purchaseproduct:invokeserver("shopitem", 232, "99")
    end
end)

shop:button('buy pumpkins', function()
    for i = 1, 12 do
        replicatedstorage.relay.market.purchaseproduct:invokeserver("shopitem", 231, "99")
    end
end)

shop:button('buy feed', function()
    replicatedstorage.relay.market.purchaseproduct:invokeserver("shopitem", 143, "99")
end)

window:createfolder('miscellaneous'):destroygui()
