local animEffect = 5 -- Custom effect ID/name for when the double hit procs
local procChance = 50 -- Chance for the Double Hit to proc.

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE) -- Damage type
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true) -- Is the damage affected by enemies armor? (not really sure but I'm guessing thats what it does)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0) -- Damage Formula

function doDoubleHit(player, variant) -- Function to be the callback of our addEvent later on
    return combat:execute(player, variant)
end

function onUseWeapon(player, variant)
local chance = math.random(1,100) -- Defines a random number from 1 to 100
    if chance <= procChance then -- If the number defined on the above variable is lesser or equal to the procChance, runs the code below
        combat:setParameter(COMBAT_PARAM_EFFECT, animEffect) -- As we now know it is a double hit, this line defines a new effect for the combat hit.
        combat:execute(player, variant) -- Executes the first hit
        addEvent(doDoubleHit, 500, player:getId(), variant) -- Adds an event with the doDoubleHit callback, called in 500ms
        player:say("DOUBLE", TALKTYPE_MONSTER_SAY) -- We would like the player to know he just got a double hit, so we make him say "DOUBLE" in orange.
    else return combat:setParameter(COMBAT_PARAM_EFFECT, 1) and combat:execute(player, variant) end
    -- If the number generated on the chance variable is not lesser or equal to the procChance, then it sets the animation effect to the default one and executes the combat hit as usual.
end