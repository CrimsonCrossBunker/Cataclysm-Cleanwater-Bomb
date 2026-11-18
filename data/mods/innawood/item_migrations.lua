local content = require("ccb").content

-- migration_items.json
content.add(content.ItemMigration { from = "small_squeeze_tube", to = "clay_canister" })

-- migration/items.json
-- remove after 0.J
content.add(content.ItemMigration { from = "leather_journal_innawood", to = "leather_journal" })
