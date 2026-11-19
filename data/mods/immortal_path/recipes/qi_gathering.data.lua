local ccb = require("ccb")

-- Qi-Gathering Pill
-- Qi-Gathering Pills
-- 基础回灵丹药：只补灵气，不给炼气修为，避免绕过打坐成长曲线。数值对齐一次吐纳补气量（+60）。/ Basic qi-restoring pill: restores qi only, not Qi Refining cultivation, so it does not bypass the meditation progression curve. Amount matches one meditation cast (+60 qi).
-- A pale cyan pill that melts into a warm spiritual breath and gathers in the dantian. Restores a small amount of qi, but does not increase cultivation.
-- You take a Qi-Gathering Pill, and a warm spiritual breath gathers in your dantian.
ccb.content.define_item {
    id = "immortal_path_qi_gathering_pill",
    category = "drugs",
    name = ccb.content.plural_text("聚气丹", "聚气丹"),
    description = ccb.content.text("一枚淡青色小丹，入口后化作温润灵息，汇入丹田。可补充少量灵气，但不能增长修为。"),
    mass = "8 g",
    volume = "5 ml",
    price = "0 USD",
    survival_price = "3 USD",
    materials = { "junk" },
    symbol = "*",
    color = "cyan",
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("你服下一枚聚气丹，温润灵息汇入丹田。"),
            vitamins = { { id = "qi", minimum = 60 } },
        },
    },
}
