local ccb = require("ccb")
local content = ccb.content

-- Native clothing modifications
do
local definition = content.ClothingMod {
    id = "leather_padded",
    flag = "leather_padded",
    material_item = "leather",
    apply_prompt = "Pad with leather",
    remove_prompt = "Destroy leather padding",
    restricted = false,
}
definition:modifier {
    stat = "bash",
    amount = 1,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "cut",
    amount = 1,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "bullet",
    amount = 1,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "encumbrance",
    amount = 2,
    scale = { "thickness", "coverage" },
    round_up = true,
}
definition:modifier {
    stat = "warmth",
    amount = 1,
    scale = { "thickness", "coverage" },
    round_up = false,
}
content.add(definition)
end
do
local definition = content.ClothingMod {
    id = "steel_padded",
    flag = "steel_padded",
    material_item = "steel_armor",
    apply_prompt = "Pad with steel",
    remove_prompt = "Destroy steel padding",
    restricted = true,
}
definition:modifier {
    stat = "bash",
    amount = 3,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "cut",
    amount = 3,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "bullet",
    amount = 1.5,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "encumbrance",
    amount = 5,
    scale = { "thickness", "coverage" },
    round_up = true,
}
definition:modifier {
    stat = "warmth",
    amount = 1,
    scale = { "thickness", "coverage" },
    round_up = false,
}
content.add(definition)
end
do
local definition = content.ClothingMod {
    id = "kevlar_padded",
    flag = "kevlar_padded",
    material_item = "sheet_kevlar_layered",
    apply_prompt = "Pad with Kevlar",
    remove_prompt = "Destroy Kevlar padding",
    restricted = false,
}
definition:modifier {
    stat = "bash",
    amount = 1,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "cut",
    amount = 1.5,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "bullet",
    amount = 2.5,
    scale = { "thickness" },
    round_up = false,
}
definition:modifier {
    stat = "encumbrance",
    amount = 2,
    scale = { "thickness", "coverage" },
    round_up = true,
}
definition:modifier {
    stat = "warmth",
    amount = 1,
    scale = { "thickness", "coverage" },
    round_up = false,
}
content.add(definition)
end
do
local definition = content.ClothingMod {
    id = "furred",
    flag = "furred",
    material_item = "fur",
    apply_prompt = "Line it with fur",
    remove_prompt = "Destroy fur lining",
    restricted = false,
}
definition:modifier {
    stat = "encumbrance",
    amount = 1,
    scale = {  },
    round_up = false,
}
definition:modifier {
    stat = "encumbrance",
    amount = 4,
    scale = { "coverage" },
    round_up = false,
}
definition:modifier {
    stat = "warmth",
    amount = 35,
    scale = { "coverage" },
    round_up = false,
}
content.add(definition)
end
do
local definition = content.ClothingMod {
    id = "wooled",
    flag = "wooled",
    material_item = "felt_patch",
    apply_prompt = "Line it with wool",
    remove_prompt = "Destroy wool lining",
    restricted = false,
}
definition:modifier {
    stat = "encumbrance",
    amount = 1,
    scale = {  },
    round_up = false,
}
definition:modifier {
    stat = "encumbrance",
    amount = 3,
    scale = { "coverage" },
    round_up = false,
}
definition:modifier {
    stat = "warmth",
    amount = 20,
    scale = { "coverage" },
    round_up = false,
}
content.add(definition)
end
