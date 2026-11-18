local content = require("ccb").content

do
    local book = content.Item {
        id = "magical_grimoire_apprentice_wise",
        category = "manuals",
        copy_from = "magical_grimoire_apprentice",
        looks_like = "magical_grimoire_apprentice",
        name = content.plural_text("apprentice's grimoire", "copies of apprentice's grimoire"),
        description = content.text("Written using the runes of the wise, this contains the rituals and supplications necessary to unlock the secrets of the lesser mysteries."),
    }
    content.add(book)
end
