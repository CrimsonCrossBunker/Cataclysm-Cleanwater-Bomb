local ccb = require("ccb")

local equipment = ccb.content.ItemGroup {
    id = "MONKEY_KING_PILGRIM_EQUIPMENT",
    kind = "collection",
}
equipment:item("q_staff", 100, "")
equipment:item("robe", 100, "")
equipment:item("pants", 100, "")
equipment:item("straw_sandals", 100, "")
equipment:item("backpack", 100, "")
equipment:item("bottle_plastic", 100, "")
equipment:item("bandages", 100, "")
ccb.content.add(equipment)

local pilgrim = ccb.content.Profession {
    id = "MONKEY_KING_PILGRIM",
    name = "花果山行者",
    description = "灾变唤醒了你体内的六道猴王传承。长棍在手，行囊在肩，你要在破碎的人间走出自己的取经路。娱乐向强力职业，自带全部六项猴王变异。",
    points = 8,
    chargen_allow_npc = false,
}
pilgrim:items(equipment.id, "", "")
pilgrim:skill("melee", 3)
pilgrim:skill("bashing", 3)
pilgrim:skill("dodge", 2)
pilgrim:skill("survival", 2)
pilgrim:skill("swimming", 2)
pilgrim:trait("MONKEY_KING_MIGHT", "")
pilgrim:trait("MONKEY_KING_DIAMOND_BODY", "")
pilgrim:trait("MONKEY_KING_GOLDEN_EYES", "")
pilgrim:trait("MONKEY_KING_CLOUD_STEP", "")
pilgrim:trait("MONKEY_KING_WATER_ADEPT", "")
pilgrim:trait("MONKEY_KING_ENLIGHTENED_MIND", "")
ccb.content.add(pilgrim)
