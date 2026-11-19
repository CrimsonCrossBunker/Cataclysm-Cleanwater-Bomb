local ccb = require("ccb")

-- Meditate (Breathe and Circulate Qi)
-- Sit in meditation, breathing in the qi of heaven and earth to nourish the meridians. Takes time; restores qi and accumulates Qi Refining cultivation.
-- 最基础的吐纳法术（由「吐纳引气诀」残卷授予）。无五行偏向，是其它功法吐纳变体的参照。施法即打坐，结算见 EOC_immortal_path_meditate。/ The most basic breathing art (granted by the breathing-method scroll). No phase affinity; the reference variant for all arts.
ccb.content.define_spell {
    id = "immortal_path_meditate",
    copy_from = "immortal_path_meditate_abstract",
    name = ccb.content.text("吐纳打坐"),
    description = ccb.content.text("盘膝静坐，吐纳天地灵气，温养经脉。耗费时间，补充灵气，并累积炼气境修为。"),
}
