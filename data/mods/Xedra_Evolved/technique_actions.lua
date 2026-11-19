local ccb = require("ccb")
local services = ccb.services
local creatures = services.creatures
local environment = services.gameplay.environment
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function outdoor_diggable_target(combat)
    if not checked(creatures.snapshot(combat.attacker)).outside then return nil end
    local target = checked(creatures.snapshot(combat.target))
    if target.outside and environment.terrain_has_flag(target.position, "DIGGABLE") then
        return target.position
    end
end

ccb.runtime.handler("allow_arvore_counter_trip", function(combat)
    if combat.attacker_size + 1 < combat.target_size then return false end
    local attacker = combat.attacker
    if checked(services.mutations.has_id_text(attacker, "VINES3")) then return true end
    local wielded = checked(services.inventory.wielded(attacker))
    return wielded ~= nil and checked(services.items.has_flag(wielded, id("json_flag", "MAGIC_FOCUS")))
end)

ccb.runtime.handler("arvore_counter_trip_applied", function(combat)
    local position = outdoor_diggable_target(combat)
    if position and services.random.native_probability(1, 4) then
        environment.add_field_area(position, "fd_pollen_arvore_weaken", {
            radius = 0,
            outdoor_only = true,
            intensity = 3,
        })
    end
end)

ccb.runtime.handler("arvore_falling_tree_applied", function(combat)
    if outdoor_diggable_target(combat) then
        local skill = math.modf(checked(services.skills.level(combat.attacker, "gramarye")))
        local duration = services.time.duration_from_turns(2 + skill / 2)
        local effect = id("effect", "effect_xe_ma_arvore_beneath_falling_tree_weakpoints_bonus")
        checked(services.effects.add(combat.attacker, effect, duration))
    end
end)

ccb.runtime.handler("arvore_venom_applied", function(combat)
    local target = combat.target
    local claws_active = checked(services.mutations.has_id_text(combat.attacker, "ARVORE_WOOD_CLAWS_active"))
    checked(services.variables.set(target, "has_arvore_jagged_claw_out", claws_active and 2 or 1, {
        include_before = false,
    }))
    local caster = target.subtype == "monster" and services.monsters or services.characters
    checked(caster.cast_spell(target, id("spell", "tech_xe_ma_arvore_venom_attack_spell"), { hit_self = true }))
end)
