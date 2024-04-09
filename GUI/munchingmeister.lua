repeat wait() until game:isloaded() and game.players and game.players.localplayer and game.players.localplayer.character

getgenv().autoaction = false
getgenv().autoeat = false
getgenv().autodevour = false
getgenv().autopunch = false
getgenv().autostomp = false
getgenv().autobellyflop = false
getgenv().autosell = false
getgenv().autocoins = false
getgenv().autofood = false
getgenv().autostomach = false
getgenv().autoseasoning = false
getgenv().autoskins = false
getgenv().autoking = false
getgenv().autorank = false
getgenv().autotpkil = false

local rm = game:getservice('replicatedstorage').events.player
local ws = game:getservice('workspace')

local lp = game.players.localplayer

local function touchinterest(part)
    firetouchinterest(lp.character.humanoidrootpart, part, 0)
    firetouchinterest(lp.character.humanoidrootpart, part, 1)
end

local function getroot(char)
    local rootpart = char:findfirstchild('humanoidrootpart') or char:findfirstchild('torso') or char:findfirstchild('uppertorso')
    return rootpart
end

local function tools(plr)
    return plr:findfirstchildofclass('backpack'):findfirstchildofclass('tool') or plr.character:findfirstchildofclass('tool')
end

local function r15(plr)
    return plr.character:findfirstchildofclass('humanoid').rigtype == enum.humanoidrigtype.r15
end

local function createbooleanfunctions(actions)
    local functions = {}
    for _, action in ipairs(actions) do
        getgenv()[action] = false
        functions[action] = function(bool)
            getgenv()[action] = bool
            if bool then
                spawn(function()
                    while wait() do
                        if not getgenv()[action] then break end
                        game.replicatedstorage.events.player[action]:fireserver()
                    end
                end)
            end
        end
    end
    return functions
end

local function autotpkil()
    spawn(function ()
        while wait() do
            if getgenv().autotpkil then
                for i, v in ipairs(game.players:getplayers()) do
                    if not getgenv().autotpkil then break end
                    if v.name ~= lp.name then
                        local playerloaded = lp.character or lp.characteradded:wait()
                        local playerhumanoidloaded = playerloaded:waitforchild('humanoid')
                        repeat wait()
                            rm.action:fireserver('punch')
                            if v.character ~= nil and playerhumanoidloaded and v.character.humanoidrootpart ~= nil then 
                                lp.character.humanoidrootpart.cframe = v.character.humanoidrootpart.cframe * cframe.new(0,0,0)
                            end
                        until v.character == nil or v.character.humanoid.health <= 0 or v.character.humanoidrootpart.cframe == nil or lp.character.humanoidrootpart.cframe == nil or not getgenv().autotpkil
                        totalplayerskilled += 1
                        print(totalplayerskilled)
                    else
                        wait(0.1)
                        print('no humanoid found!, switching to other player..', v.name)
                    end
                end
            end
        end
    end)
end

local booleanfunctions = createbooleanfunctions({
    "autoaction",
    "autoeat",
    "autodevour",
    "autopunch",
    "autostomp",
    "autobellyflop",
    "autosell",
    "autocoins",
    "autofood",
    "autostomach",
    "autoseasoning",
    "autoskins",
    "autoking",
    "autorank",
    "autotpkil"
})

local function sellall()
    spawn(function()
        for i=1,30 do
            game:getservice("replicatedstorage").relay.inventory.storeitems:invokeserver(i+9, "backpack", "sell", 99)
        end
    
        game:getservice("replicatedstorage").relay.inventory.sellitems:invokeserver()
    end)
end

local function harvestline(x, y, l, level, delay)
    spawn(function()
        for i=1,l do
            game:getservice("replicatedstorage").relay.blocks.harvestcrop:invokeserver(vector3.new(x, level, y+i))
        end
    end)
    wait(delay)
end

local function placeline(x, y, l, level, delay)
    spawn(function()
        for i=1,l do
            local args = {
                [1] = 89,
                [2] = vector3.new(x, level, y+i),
                [3] = 3,
                [4] = false
            }
            game:getservice("replicatedstorage").relay.blocks.placedecor:invokeserver(unpack(args))

        end
    end)
    wait(delay)
end

local function storeline(x, y, l, level, delay)
    spawn(function()
        for i=1,l do
            game:getservice("replicatedstorage").relay.blocks.storedecor:invokeserver(vector3.new(x, level, y+i))
        end
    end)
    wait(delay)
end

local function buycranberries()
    for i=1,10 do
        local args = {
            [1] = "shopitem",
            [2] = 232,
            [3] = "99"
        }
        game:getservice("replicatedstorage").relay.market.purchaseproduct:invokeserver(unpack(args))
    end
end

local function buypumpkins()
    for i=1,12 do
        local args = {
            [1] = "shopitem",
            [2] = 231,
            [3] = "99"
        }
        game:getservice("replicatedstorage").relay.market.purchaseproduct:invokeserver(unpack(args))
    end
end

local function buyfeed()
    for i=1,1 do
        local args = {
            [1] = "shopitem",
            [2] = 143,
            [3] = "99"
        }
        game:getservice("replicatedstorage").relay.market.purchaseproduct:invokeserver(unpack(args))
    end
end

local function rejoinserver()
    local teleportservice = game:getservice('teleportservice')
    local players = game:getservice('players')
    local localplayer = players.localplayer
    
    local rejoin = coroutine.create(function()
        local success, errormessage = pcall(function()
            teleportservice:teleporttoprivateserver(game.placeid, localplayer)
        end)
    
        if errormessage and not success then
            warn(errormessage)
        end
    end)
    
    coroutine.resume(rejoin)
end

local function redeemallcodes()
    local codes = {'food', '50m', 'hungry', '2m', 'release', 'scotty', 'tofuu', 'BARO'}
    for i, v in pairs(codes) do
        rm.code:fireserver(v:upper())
        print(v)
    end
end

local function destroyeverything()
    if ws.world then
        ws.world:destroy()
    end
    if ws.edible then
        ws.edible:destroy()
    end
end

local function destroysellpads()
    if ws.sell then
        ws.sell:destroy()
    end
end

local function destroybuypads()
    if ws.buy then
        ws.buy:destroy()
    end
end

local function destroyrankskinpads()
    if ws.other then
        ws.other:destroy()
    end
end

local function destroyquestgiver()
    if ws.questgiver then
        ws.questgiver:destroy()
    end
end

local function destroyportals()
    if ws.mgnportals then
        ws.mgnportals:destroy()
    end
end

local function destroybarriers()
    if ws.mgnportals then
        ws.barriers:destroy()
    end
end

local function destroysafezone()
    if ws.safezone then
        ws.safezone:destroy()
    end
end

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:createwindow('munching meister!')

local farming = w:createfolder('farming')
local fighting = w:createfolder('fighting')
local teleport = w:createfolder('teleport')
local destroy = w:createfolder('destroy')
local misc = w:createfolder('miscellaneous')
local credits = w:createfolder('credits')

for action, func in pairs(booleanfunctions) do
    farming:toggle(action:gsub("^%l", string.upper), func)
end

fighting:toggle('auto tp kill', autotpkil)

farming:button('auto eat', autoeat)
farming:button('auto sell', autosell)
farming:button('auto coins', autocoins)
farming:button('auto king', autoking)
farming:button('auto rank', autorank)

fighting:button('auto punch', autopunch)
fighting:button('auto stomp', autostomp)
fighting:button('auto devour', autodevour)
fighting:button('auto belly flop', autobellyflop)

misc:button('rejoin server', rejoinserver)
misc:button('redeem all codes', redeemallcodes)

destroy:button('destroy everything', destroyeverything)
destroy:button('destroy sell pads', destroysellpads)
destroy:button('destroy buy pads', destroybuypads)
destroy:button('destroy rank/skin pads', destroyrankskinpads)
destroy:button('destroy quest giver', destroyquestgiver)
destroy:button('destroy portals', destroyportals)
destroy:button('destroy barriers', destroybarriers)
destroy:button('destroy safezone', destroysafezone)

misc:destroygui()