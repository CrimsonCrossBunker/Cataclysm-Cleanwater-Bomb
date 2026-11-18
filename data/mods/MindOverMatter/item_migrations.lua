local content = require("ccb").content

-- obsolete/items.json
-- remove after 0.J
content.add(content.ItemMigration { from = { "biokin_breathe_skin_item" }, to = "manual_swimming" })
-- remove after 0.J
content.add(content.ItemMigration { from = { "psionic_shield_belt_broken" }, to = "psionic_shield_belt" })
-- remove after 0.J
content.add(content.ItemMigration {
    from = { "psionic_fire_shield_belt_broken" },
    to = "psionic_fire_shield_belt",
})
