local content = require("ccb").content

do
    -- obsoleted
    local book = content.Item {
        id = "spell_scroll_summon_zombie",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Zombie", "Scrolls of Summon Zombie"),
        description = content.text("An ethereal-looking zombie rises from the depths of the earth to fight for you.  You may be able to summon more with a higher level in this spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_undead" })
    content.add(book)
end

do
    -- obsoleted
    local book = content.Item {
        id = "spell_scroll_summon_skeleton",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Skeleton", "Scrolls of Summon Skeleton"),
        description = content.text("A ghostly skeleton rises from the depths of the earth to fight for you.  You may be able to summon more with a higher level in this spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_undead" })
    content.add(book)
end

do
    -- obsoleted
    local book = content.Item {
        id = "spell_scroll_summon_decayed_pouncer",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Decayed Pouncer", "Scrolls of Summon Decayed Pouncer"),
        description = content.text("A decrepit looking large cat rises from the depths of the earth to fight for you.  You may be able to summon more with a higher level in this spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_decayed_pouncer" })
    content.add(book)
end
