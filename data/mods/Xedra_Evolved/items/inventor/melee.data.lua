local ccb = require("ccb")

ccb.content.define_item {
    id = "binary_sword",
    copy_from = "qt_zweihander",
    name = ccb.content.plural_text("binary sword", "binary swords"),
    description = ccb.content.text("A relatively heavy two-handed sword with \"100111100\" inscribed on the blade, perhaps to appear fancier than it truly is.  Still, it is a surprisingly good weapon."),
    replace_materials = { kevlar = "kevlar" },
    inheritance = { offset = { melee_damage = { pure = 6 } } },
    tool = {},
}
