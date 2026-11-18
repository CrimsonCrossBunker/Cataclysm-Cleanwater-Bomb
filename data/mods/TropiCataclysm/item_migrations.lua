local content = require("ccb").content

-- migrations_0.J/items.json
content.add(content.ItemMigration { from = "fungus_mutated", to = "veggy_tainted" })
content.add(content.ItemMigration { from = "egg_monitor", to = "egg_iguana" })
content.add(content.ItemMigration { from = "egg_snapper", to = "egg_turtle" })
content.add(content.ItemMigration { from = "egg_salamander", to = "egg_tadfish" })
