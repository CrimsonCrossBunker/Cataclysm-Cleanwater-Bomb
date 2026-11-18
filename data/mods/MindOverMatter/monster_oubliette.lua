local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function travel(character, dimension)
    local result = checked(services.relocation.travel_to_dimension(dimension,
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
    if character.subtype == "avatar" then
        local success = dimension == "default"
            and "Your surroundings warp and fold into the recesses of the world you know."
            or "Your surroundings warp and fold before reforming into a strange landscape."
        local failure = dimension == "default" and "Nothing seems to change."
            or "You experience brief vertigo, but nothing dangerous seems to happen."
        services.messages.add(services.translate(result.accepted and success or failure), "neutral")
    end
end

ccb.runtime.handler("mom_oubliette_return_due", function(payload)
    travel(payload.character, "default")
end)

ccb.runtime.handler("mom_oubliette_highlands_return_due", function(payload)
    ccb.runtime.call_character("portal_highlands_return", payload.character)
end)

local function banish_avatar(character)
    local duration = 3600 + services.random.native_int(0, 259200)
    local roll = services.random.native_int(0, 8)
    local dimension
    if roll >= 7 then
        -- Native switch uses the last matching lower bound; its second case 7 replaces Mycus.
        dimension = "mom_shoggothed_world"
    elseif roll >= 6 then
        dimension = "highlands"
    elseif roll >= 4 then
        dimension = "mom_innawood_rainy"
    else
        dimension = "mom_innawood"
    end
    travel(character, dimension)
    ccb.tasks.after_character_turn(character, duration,
        dimension == "highlands" and "mom_oubliette_highlands_return_due" or "mom_oubliette_return_due")
end

ccb.runtime.handler("mom_oubliette_monster_impact", function(impact)
    local target = impact.target_creature
    if not target then return end
    local character = target.subtype == "avatar" or target.subtype == "npc" or target.subtype == "character"
    local blocked = checked(services.creatures.has_flag_text(target, "TELESTOP"))
        or checked(services.creatures.has_flag_text(target, "TELEPORT_IMMUNE"))
        or checked(services.creatures.has_flag_text(target, "TELEPORT_LOCK"))
        or (character and checked(services.inventory.has_worn_flag(target, id("json_flag", "DIMENSIONAL_ANCHOR"))))
    if blocked then
        if target.subtype == "avatar" then
            services.messages.add(services.translate("You feel a strange, inward force."), "neutral")
        end
        return
    end
    local damage = 50 + services.random.native_int(0, 100)
    local death = { remove_corpse = true, suppress_message = true }
    if character then
        local hp = 0
        for _, part in ipairs { "arm_l", "arm_r", "leg_l", "leg_r", "torso", "head" } do
            hp = hp + checked(services.characters.hp(target, id("body_part", part)))
        end
        if damage >= hp / 3 then
            if target.subtype == "avatar" then
                banish_avatar(target)
            else
                checked(services.characters.die(target, death))
            end
        end
    elseif target.subtype == "monster" and damage >= checked(services.creatures.snapshot(target)).hp then
        checked(services.monsters.die(target, death))
    end
end)

ccb.content.add(ccb.content.Spell {
    id = "teleport_oubliette_monster",
    name = "[Ψ]Oubliette Monster",
    description = "The monster sends you to another dimension, just like you could have done to it.  Turnabout is fair play.",
    message = "", teachable = false,
    valid_targets = { "hostile" },
    spell_class = "TELEPORTER", skill = "metaphysics",
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS" },
    max_level = 10,
    shape = "blast",
    min_range = 3, max_range = 3,
}:lua_impact("mom_oubliette_monster_impact"))
