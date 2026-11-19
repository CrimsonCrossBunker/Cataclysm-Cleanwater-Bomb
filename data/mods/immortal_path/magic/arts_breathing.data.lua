local ccb = require("ccb")

-- Nourishing Guidance
-- The breathing method of the Sutra of Verdant Flourishing. Draws the living qi of Wood into the body; the meridians sprout like spring wood. Advances Qi Refining while nourishing vitality.
-- 木行功法吐纳变体。结算同 EOC_immortal_path_meditate；木行特色（回血/回体力/木行极化）由载体特性「草木同春」承担，非本 spell。/ Wood-phase variant. Settlement shared; Wood flavor is on the carrier trait.
ccb.content.define_spell {
    id = "immortal_path_meditate_evergreen",
    copy_from = "immortal_path_meditate_abstract",
    effect_data = "EOC_immortal_path_meditate_phase_evergreen",
    name = ccb.content.text("养荣导引"),
    description = ccb.content.text("葳蕤经的吐纳法门。引木行生气入体，经脉如春木抽枝，温养之余更添生机。打坐推进炼气修为，兼能滋养气血。"),
}

-- Flame-Tempering Breath
-- The breathing method of the Blazing Sun Transmission. Takes the blazing qi of Fire into the dantian, scorching the meridians. Cultivation tempers the body with yang force.
-- 火行功法吐纳变体。火行特色（近战伤害/抗寒/火行极化）由载体特性「阳炎附骨」承担。/ Fire-phase variant. Fire flavor on the carrier trait.
ccb.content.define_spell {
    id = "immortal_path_meditate_blazing_sun",
    copy_from = "immortal_path_meditate_abstract",
    effect_data = "EOC_immortal_path_meditate_phase_blazing_sun",
    name = ccb.content.text("炼焰息"),
    description = ccb.content.text("炎阳真传的吐纳法门。纳火行炎气入丹田，烈烈如日，灼炼经脉。修炼之余，体魄渐染炎上之力。"),
}

-- Mountain-Pressing Breath
-- The breathing method of the Bedrock Chapter. Sinks the breath into the ground, gathering the ponderous essence of Earth, steady as a mountain. Cultivation makes the body solid and hard to budge.
-- 土行功法吐纳变体。土行特色（护甲/抗击退击倒/土行极化）由载体特性「不动如山」承担。/ Earth-phase variant. Earth flavor on the carrier trait.
ccb.content.define_spell {
    id = "immortal_path_meditate_deep_earth",
    copy_from = "immortal_path_meditate_abstract",
    effect_data = "EOC_immortal_path_meditate_phase_deep_earth",
    name = ccb.content.text("镇岳吐纳"),
    description = ccb.content.text("磐石篇的吐纳法门。沉气入地，纳土行厚重之元，稳如山岳。修炼使体魄坚凝，不易撼动。"),
}

-- Edge-Quenching Method
-- The breathing method of the Record of the Bared Edge. Draws the sharp qi of Metal into the body, forging sinew and bone like tempered steel. Cultivation sharpens one's strikes.
-- 金行功法吐纳变体。金行特色（破甲/命中/金行极化）由载体特性「百炼成锋」承担。/ Metal-phase variant. Metal flavor on the carrier trait.
ccb.content.define_spell {
    id = "immortal_path_meditate_true_metal",
    copy_from = "immortal_path_meditate_abstract",
    effect_data = "EOC_immortal_path_meditate_phase_true_metal",
    name = ccb.content.text("淬锋诀"),
    description = ccb.content.text("素锋录的吐纳法门。引金行锐气入体，淬炼筋骨如百炼精钢。修炼之余，出手愈发锋锐。"),
}

-- River-Gathering Breath
-- The breathing method of the Abyssal Heart Method. The mind still as standing water, taking in the utmost-yin qi of Water; the dantian holds qi like an abyss holds rivers. Cultivation deepens and widens the qi reserve.
-- 水行功法吐纳变体。水行特色（灵气上限加成/回灵气快/水行极化）由载体特性「渊渟」承担。/ Water-phase variant. Water flavor on the carrier trait.
ccb.content.define_spell {
    id = "immortal_path_meditate_cold_pool",
    copy_from = "immortal_path_meditate_abstract",
    effect_data = "EOC_immortal_path_meditate_phase_cold_pool",
    name = ccb.content.text("纳川息"),
    description = ccb.content.text("玄渊心法的吐纳法门。心静如止水，纳水行至阴之气，丹田如渊纳百川。修炼使灵气蓄养更深更广。"),
}

-- Blood-Drawing Breath
-- The breathing method of the Blood-Fiend Corpse Refining. Draws in the death-qi and blood-fiend essence, refining corpses for nourishment to surge cultivation — but it gnaws the meridians and erodes one's foundation. A demonic shortcut; beware.
-- 魔功吐纳变体。结算暂同 EOC_immortal_path_meditate（与五行功法同口径）；邪道代价（损 health）暂由载体特性「血煞侵髓」的被动承担，「需附近尸体/血液才加速」等机制留待后续。/ Demonic variant. Settlement currently shared with the elemental arts; the dark cost (health drain) is a placeholder on the carrier trait. Corpse/blood-gated speedup is left for later.
ccb.content.define_spell {
    id = "immortal_path_meditate_blood_fiend",
    copy_from = "immortal_path_meditate_abstract",
    name = ccb.content.text("摄血息"),
    description = ccb.content.text("血煞炼尸功的吐纳法门。摄死气血煞入体，炼尸为养，催修为暴进——然反噬经脉、有损根本。此乃邪道捷径，慎之。"),
}
