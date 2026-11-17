local ccb = require("ccb")

ccb.runtime.handler("iron_arm_damage", function(ctx)
    local inputs = ctx.character_inputs
    return math.min(15, inputs.body_part_armor.arm_r.bash * inputs.attack_speed / 200)
end)

ccb.content.add(ccb.content.Enchantment {
    id = "INLINE_ENCH_perk_jugg_0",
    load_character_inputs = { body_part_armor = { arm_r = { "bash" } }, attack_speed = true },
    native_modifier_order = true,
}
    :melee_damage("bash", { add_handler = "iron_arm_damage", load_skills = {} }))
