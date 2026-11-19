local ccb = require("ccb")

-- Qi Refining
-- Qi Refining realm: draw qi into the body and nourish the meridians. This 'spell' is never cast manually; it merely tracks cultivation progress — its level is the stage within the Qi Refining realm (1st to 13th layer).
-- 境界进度容器：用 spell level 表示炼气境的小层。不可施放、无实际效果。等级由吐纳/突破 EOC 推进，灵气上限表达式读取本 spell 的 level。详见 doc/02_cultivation_realms.md 与 doc/03_qi_system.md。
-- 法术派系即变异：修炼炼气境=拥有「炼气士」派系特性，该特性携带 qi_max enchantment 抬升灵气上限。引擎在 learn_spell 时会自动授予 spell_class 特性（src/magic.cpp set_mutation），但本 mod 用 set_spell_level 直接设级别（不走 learn_spell、不自动授予），故另由 EOC_immortal_path_bind_realm_trait（监听 character_learns_spell）+ EOC_immortal_path_ensure_realm_trait（RECURRING 兜底旧存档）并行补发。/ Spell class is a mutation: cultivating Qi Refining = having the Qi Cultivator trait, which carries the qi_max enchantment. learn_spell auto-grants the class trait, but this mod sets levels via set_spell_level (no auto-grant), so two EOCs grant it in parallel.
-- 炼气十三层。/ Qi Refining has 13 layers.
-- 用二次递增经验曲线（exp_for(L)=86·L·(L+1)，单层增量 172·L 线性递增；系数 86 由「正常天赋纯打坐约 100 天炼气圆满」反推），「越靠后越慢」是曲线内在属性，所有经验来源给固定不打折 exp 即可；默认指数曲线是为战斗法术调的，太陡。见 jmath immortal_path_realm_exp_for_level。/ Quadratic exp curve (86·L·(L+1), coefficient set so normal aptitude fills Qi Refining in ~100 days of pure meditation); 'slower when higher' is intrinsic, so all exp sources grant flat exp. The default exponential curve is tuned for combat spells and too steep.
ccb.content.define_spell {
    id = "realm_qi_refining",
    name = ccb.content.text("炼气"),
    description = ccb.content.text("炼气境：引气入体，温养经脉。此「法术」不可主动施放，仅作修为进度的载体——其等级即炼气境的层数（一层至十三层）。"),
    valid_targets = { "self" },
    effect = "none",
    shape = "blast",
    energy_source = "NONE",
    spell_class = "immortal_path_qi_cultivator",
    flags = { "NO_FAIL", "HIDDEN_SPELL", "SILENT", "NO_HANDS", "NO_LEGS" },
    base_casting_time = 1,
    base_energy_cost = 0,
    difficulty = 0,
    max_level = 13,
    get_level_formula = "immortal_path_realm_get_level",
    exp_for_level_formula = "immortal_path_realm_exp_for_level",
    min_damage = 0,
    max_damage = 0,
    min_range = 0,
    max_range = 0,
}
