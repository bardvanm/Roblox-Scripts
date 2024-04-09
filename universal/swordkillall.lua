local lp = game.Players.LocalPlayer
local swords = {}
local names = {"BasicSword", "InfernalSword", "DiamondSword", "LegendaryBlade", "MythicalKatana", "FrostbiteEdge", "ThunderstrikeSaber", "Shadowblade", "EtherealRapier", "DivineExcalibur", "SoulrenderScimitar"}
local attackDelay = 1

for _, name in ipairs(names) do
    local tool = nil
    for _, toolInBackpack in pairs(lp.Backpack:GetChildren()) do
        if toolInBackpack:IsA("Tool") and toolInBackpack.Name == name then
            tool = toolInBackpack
            break
        end
    end
    if not tool then
        for _, toolInCharacter in pairs(lp.Character:GetChildren()) do
            if toolInCharacter:IsA("Tool") and toolInCharacter.Name == name then
                tool = toolInCharacter
                break
            end
        end
    end
    if tool then
        table.insert(swords, tool)
    end
end

local function teleAndAttack(player, swords)
    for _, sword in ipairs(swords) do
        lp.Character:MoveTo(player.Character.HumanoidRootPart.Position)
        wait(attackDelay)
        sword:Activate() 
        wait(attackDelay)
    end
end

for _, sword in ipairs(swords) do
    sword.Parent = lp.Character
    lp.Character.Humanoid:EquipTool(sword)
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= lp then
        teleAndAttack(player, swords)
    end
end
