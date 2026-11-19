local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function set_number(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

ccb.runtime.handler("perk_update_weapon_stats", function(event)
    local character = event.actors.character or services.characters.avatar()
    if not character:is_valid() then return end

    local weapon = checked(services.inventory.wielded(character))
    if not weapon then return end

    local damage = services.items.melee_damage
    local total = checked(damage(weapon))
    local bash = checked(damage(weapon, id("damage_type", "bash")))
    local cut = checked(damage(weapon, id("damage_type", "cut")))
    local stab = checked(damage(weapon, id("damage_type", "stab")))
    local best = math.max(bash, cut, stab)
    local scaling_type = cut == best and "cut" or stab == best and "stab" or "bash"

    set_number(character, "perk_mymelee", total)
    set_number(character, "perk_mymelee_bash", bash)
    set_number(character, "perk_mymelee_cut", cut)
    set_number(character, "perk_mymelee_stab", stab)
    set_number(character, "perk_mymelee_best_damage", best)
    for _, kind in ipairs({ "bash", "cut", "stab" }) do
        set_number(character, "perk_insight_" .. kind .. "_scaling", kind == scaling_type and 1 or 0)
    end
end)
ccb.runtime.on("game:character_wields_item", "perk_update_weapon_stats")

ccb.runtime.handler("perk_mark_melee_hit", function(event)
    local target = event.actors.interlocutor
    if not event.data.hits or not target or not target:is_valid() then return end

    local result = services.effects.add(target, id("effect", "perk_hit_marker"), services.time.duration_from_turns(2))
    if not result.ok and result.error.code ~= "rejected" then error(result.error.message) end
end)
ccb.runtime.on("game:character_melee_attacks_monster", "perk_mark_melee_hit")
ccb.runtime.on("game:character_melee_attacks_character", "perk_mark_melee_hit")
