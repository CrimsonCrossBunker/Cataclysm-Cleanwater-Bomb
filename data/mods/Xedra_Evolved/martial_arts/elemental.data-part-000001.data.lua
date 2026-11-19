local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_VENOM_ATTACK",
    name = ccb.content.text("Nightshade's Touch"),
    messages = {
        ccb.content.text("As you strike %s, you infuse them with the essence of nightshade."),
        ccb.content.text("<npcname> hits %s."),
    },
    skills = { { id = "unarmed", level = 3 }, { id = "gramarye", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    required_buffs_any = { "xe_ma_buff_arvore_block", "xe_ma_buff_arvore_block_increase" },
    on_apply = "arvore_venom_applied",
}
