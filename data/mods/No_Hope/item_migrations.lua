local content = require("ccb").content

-- migrations.json
content.add(content.ItemMigration { from = "mutagen", to = "purifier" })
content.add(content.ItemMigration { from = "mutagen", to = "iv_purifier" })
