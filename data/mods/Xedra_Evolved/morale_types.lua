local ccb = require("ccb")
local content = ccb.content

content.add(content.MoraleType {
    id = "morale_ate_dross",
    text = ccb.content.text("Ate dreamdross"),
})

content.add(content.MoraleType {
    id = "morale_drank_blood",
    text = ccb.content.text("Satisfied your vampiric hunger"),
})

content.add(content.MoraleType {
    id = "morale_craving_human_blood",
    text = ccb.content.text("A crimson taste at the back of your mouth"),
})

content.add(content.MoraleType {
    id = "morale_craving_lotus_blossom",
    text = ccb.content.text("A hum at the edge of your thoughts"),
})

content.add(content.MoraleType {
    id = "morale_broke_fae_ban",
    text = ccb.content.text("Broke one of the ancient laws of the fae"),
})

content.add(content.MoraleType {
    id = "morale_homullus_self_deception",
    text = ccb.content.text("Focusing on the positive"),
})

content.add(content.MoraleType {
    id = "morale_ierde_meditation",
    text = ccb.content.text("Certainty of stone"),
})

content.add(content.MoraleType {
    id = "morale_boring_fruit",
    text = ccb.content.text("Boring aftertaste"),
})

content.add(content.MoraleType {
    id = "morale_vw_no_fun",
    text = ccb.content.text("Barred from mortal joys"),
})

content.add(content.MoraleType {
    id = "morale_book_lies",
    text = ccb.content.text("Haunted by the Lies"),
})

content.add(content.MoraleType {
    id = "morale_game_inventor",
    text = ccb.content.text("Entertained by created dreams"),
})

content.add(content.MoraleType {
    id = "morale_sweet_dreams",
    text = ccb.content.text("Comforted by your sweet dream"),
})

content.replace(content.MoraleType {
    id = "morale_nightmare",
    text = ccb.content.text("Bothered by your nightmare"),
})

content.add(content.MoraleType {
    id = "morale_minoan_orchid",
    text = ccb.content.text("Minoan Orchid"),
})
