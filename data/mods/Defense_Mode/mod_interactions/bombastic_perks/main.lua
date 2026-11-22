local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("money_maker_setup", function()
    checked(services.variables.set_global("wave_money_modifier", -1500, { include_before = false }))
end)

ccb.runtime.handler("extra_life_addup", function()
    local count = checked(services.variables.get_global_number("revivication_counter")).value or 0
    checked(services.variables.set_global("revivication_counter", count + 1, { include_before = false }))
end)

ccb.runtime.handler("mysterious_stranger_activate", function(context)
    local character = context.character
    local cooldown = services.types.id("effect", "mysterious_stranger_cooldown")
    if checked(services.effects.has(character, cooldown)) then
        if character.subtype == "avatar" then
            services.messages.add(services.translate("Nobody hears you…"), "neutral")
        end
        return
    end
    local position = checked(services.creatures.snapshot(character)).position
    local spawn = services.spawns.npc(services.types.id("npc_template", "mysterious_stranger"), position, {
        min_radius = 2,
        max_radius = 3,
        traits = { services.types.id("mutation", "DEBUG_NODMG") },
        lifespan = services.time.duration(30, "second"),
    })
    if spawn.ok then
        checked(services.effects.add(character, cooldown, services.time.duration(2, "day")))
    end
end)

-- mod_interactions/bombastic_perks/perks.json
ccb.runtime.handler("interaction_enchantment_active_inline_ench_perk_melee_master_0", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_melee_master_0",
    condition_handler = "interaction_enchantment_active_inline_ench_perk_melee_master_0",
    load_character_inputs = { armed = true },
    native_modifier_order = true,
}
    :melee_damage("cut", { add = 10 })
    :melee_damage("stab", { add = 10 })
    :melee_damage("bash", { add = 10 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_gymrat_king_0",
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", { multiply = 0.8 }))

local weapon_perks = {
    { id = "INLINE_ENCH_perk_slice&dice_0", damage = "cut", bonus = 5 },
    { id = "INLINE_ENCH_perk_bash&mash_0", damage = "bash", bonus = 5 },
    { id = "INLINE_ENCH_perk_knifey_0", damage = "stab", bonus = 5 },
}

for _, perk in ipairs(weapon_perks) do
    local damage = perk.damage
    local handler = "weapon_" .. damage .. "_perk_active"
    ccb.runtime.handler(handler, function(ctx)
        return ctx.character_inputs.wielded_damage[damage] > 1
    end)
    content.upsert_enchantment(content.Enchantment {
        id = perk.id,
        condition_handler = handler,
        load_character_inputs = { wielded_damage = { damage } },
        native_modifier_order = true,
    }
        :melee_damage(damage, { add = perk.bonus }))
end

ccb.content.add(ccb.content.EffectType {
    id = "mysterious_stranger_cooldown",
    name = ccb.content.text("Mysterious Stranger's Break"),
    description = ccb.content.text("The stranger will be back…"),
    apply_message = ccb.content.text("The stranger will be back…"),
    rating = "bad",
})
