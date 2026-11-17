local ccb = require("ccb")
local content = ccb.content

-- Qi
-- 灵气：本 mod 的独立修炼能量池，与 mana/智力解耦。/ Qi: the mod's standalone cultivation energy pool, decoupled from mana/INT.
-- 静态 max 仅作防溢出兜底（远高于化神满级理论值）；当前生效上限由境界 spell level 经 math 表达式动态计算，并由 qi_clamp EOC 钳制。详见 doc/03_qi_system.md。/ Static max is only an overflow safety net; the effective cap is computed dynamically from realm spell levels and clamped by the qi_clamp EOC.
-- 被动回复设为 0；灵气恢复走主动吐纳打坐（activity + EOC），不做被动代谢。/ No passive regen; qi is restored via active meditation, not metabolism.
content.add(content.Vitamin {
    id = "qi",
    name = ccb.content.text("灵气"),
    kind = "counter",
    minimum = 0,
    maximum = 1000000,
    rate_turns = 0,
})
-- Mental Fatigue
-- 心神疲惫度：连续打坐累积，压低**打坐**经验收益（只乘打坐 exp，不影响丹药/炼化，也不影响灵气回复）。随时间自然衰减（rate 正值=每多少时间退 1 点），休息/睡觉照退。用于「避免一气连打过多」——session 级软限制、无硬墙，与「越高越慢」（由递增经验曲线承担）正交。远期可与「走火入魔」挂钩（疲惫过高时打坐有反噬）。详见仓库外 immortal_path_design。/ Mental fatigue from continuous meditation; suppresses meditation EXP yield only (not pills/refining, not qi restore). Decays over time so resting/sleeping clears it. A soft, session-level cap on binge meditation, orthogonal to the curve's 'slower when higher'.
-- 每 7 分钟自然退 1 点。一次打坐施法 ≈16 分钟、+22 疲惫；连续约 4 次（≈1 小时）后疲惫 ≈88，第 5 次乘子归零自然截断——这就是「一轮」。88 点按 7 分钟/点 ≈10.3 小时退尽，正常作息每日自然约 2 轮（睡觉照退、醒来已大半恢复）。配合打坐基础 exp 33，每日约 156 exp，炼气圆满仍约 100 天。/ Loses 1 per 7 min. One cast ≈16 min, +22 fatigue; ~4 casts (~1 hour) cap fatigue near 88 and the 5th yields 0 — that is one 'bout'. 88 points clear in ~10.3 h, so normal sleep/wake cycles allow ~2 bouts/day. With base exp 33 that's ~156 exp/day, Qi Refining still ~100 days to fill.
content.add(content.Vitamin {
    id = "qi_fatigue",
    name = ccb.content.text("心神疲惫"),
    kind = "counter",
    minimum = 0,
    maximum = 1000,
    rate_turns = 420,
})
