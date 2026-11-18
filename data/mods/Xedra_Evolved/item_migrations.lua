local content = require("ccb").content

-- obsoletion_and_migration/items.json
content.add(content.ItemMigration {
    from = {
        "integrated_nobreathe",
        "integrated_sylph_breath",
        "integrated_arvore_eyes",
        "integrated_ierde_eyes",
        "integrated_homullus_eyes",
        "integrated_salamander_eyes",
        "integrated_sylph_eyes",
        "integrated_undine_eyes",
    },
    to = "manual_swimming",
})

-- obsoletion_and_migration/migration.json
content.add(content.ItemMigration { from = "ray_diagrams", to = "firmament_driver_book" })
content.add(content.ItemMigration { from = "ray_weapon_diagrams", to = "firmament_driver_book" })
content.add(content.ItemMigration { from = "syringe_artifact", to = "firmament_driver_book" })
content.add(content.ItemMigration { from = "money_strap_magic", to = "artifact_cable_whip" })
content.add(content.ItemMigration { from = "foil_hat", to = "artifact_cable_whip" })
content.add(content.ItemMigration { from = "book_inventor", to = "artifact_cable_whip" })
