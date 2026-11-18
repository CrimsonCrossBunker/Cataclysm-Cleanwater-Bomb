local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "spell_wand",
        abstract = true,
        name = ccb.content.plural_text("Magic Wand", "Magic Wands"),
        mass_milligrams = 230000,
        volume_ml = 500,
        longest_side_mm = 380,
        price_cents = 40000,
        melee_to_hit = 1,
        symbol = "|",
        color = "brown",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool { charges_per_use = 1, ammo_types = { "crystallized_mana" } }
    item:magazine_well {
        max_volume_ml = 20000,
        max_weight_milligrams = 20000000,
        holster = true,
        allowed_items = { "small_mana_crystal" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "disp_wand",
        abstract = true,
        name = ccb.content.plural_text("Disposable Wand", "Disposable Wands"),
        mass_milligrams = 230000,
        volume_ml = 500,
        longest_side_mm = 380,
        price_cents = 10000,
        melee_to_hit = 1,
        symbol = "|",
        color = "brown",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { crystallized_mana = 20 }, holster = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_magic_missile_minor",
        name = ccb.content.plural_text("minor wand of magic missile", "minor wands of magic missile"),
        copy_from = "spell_wand",
        price_postapoc_cents = 15000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts magic missile."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magic_missile_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_magic_missile_lesser",
        name = ccb.content.plural_text("lesser wand of magic missile", "lesser wands of magic missile"),
        copy_from = "spell_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts magic missile."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magic_missile_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_magic_missile_greater",
        name = ccb.content.plural_text("greater wand of magic missile", "greater wands of magic missile"),
        copy_from = "spell_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts magic missile."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magic_missile_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_fireball_minor",
        name = ccb.content.plural_text("minor wand of fireball", "minor wands of fireball"),
        copy_from = "spell_wand",
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts fireball."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "fireball_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_fireball_lesser",
        name = ccb.content.plural_text("lesser wand of fireball", "lesser wands of fireball"),
        copy_from = "spell_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts fireball."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "fireball_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_fireball_greater",
        name = ccb.content.plural_text("greater wand of fireball", "greater wands of fireball"),
        copy_from = "spell_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts fireball."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "fireball_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_mana_beam_minor",
        name = ccb.content.plural_text("minor wand of mana beam", "minor wands of mana beam"),
        copy_from = "spell_wand",
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts mana beam."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magus_mana_beam_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_mana_beam_lesser",
        name = ccb.content.plural_text("lesser wand of mana beam", "lesser wands of mana beam"),
        copy_from = "spell_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts mana beam."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magus_mana_beam_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_mana_beam_greater",
        name = ccb.content.plural_text("greater wand of mana beam", "greater wands of mana beam"),
        copy_from = "spell_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts mana beam."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magus_mana_beam_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_point_flare_minor",
        name = ccb.content.plural_text("minor wand of point flare", "minor wands of point flare"),
        copy_from = "spell_wand",
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts point flare."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "point_flare_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_point_flare_lesser",
        name = ccb.content.plural_text("lesser wand of point flare", "lesser wands of point flare"),
        copy_from = "spell_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts point flare."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "point_flare_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_point_flare_greater",
        name = ccb.content.plural_text("greater wand of point flare", "greater wands of point flare"),
        copy_from = "spell_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts point flare."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "point_flare_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_hoaryblast_minor",
        name = ccb.content.plural_text("minor wand of hoary blast", "minor wands of hoary blast"),
        copy_from = "spell_wand",
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts hoary blast."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "hoary_blast_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_hoaryblast_lesser",
        name = ccb.content.plural_text("lesser wand of hoary blast", "lesser wands of hoary blast"),
        copy_from = "spell_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts hoary blast."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "hoary_blast_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_hoaryblast_greater",
        name = ccb.content.plural_text("greater wand of hoary blast", "greater wands of hoary blast"),
        copy_from = "spell_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts hoary blast."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "hoary_blast_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_cone_cold_minor",
        name = ccb.content.plural_text("minor wand of cone of cold", "minor wands of cone of cold"),
        copy_from = "spell_wand",
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts cone of cold."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "cone_cold_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_cone_cold_lesser",
        name = ccb.content.plural_text("lesser wand of cone of cold", "lesser wands of cone of cold"),
        copy_from = "spell_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts cone of cold."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "cone_cold_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_cone_cold_greater",
        name = ccb.content.plural_text("greater wand of cone of cold", "greater wands of cone of cold"),
        copy_from = "spell_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts cone of cold."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "cone_cold_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_knock_minor",
        name = ccb.content.plural_text("minor wand of knock", "minor wands of knock"),
        copy_from = "spell_wand",
        price_cents = 5000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "knock", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_knock_lesser",
        name = ccb.content.plural_text("lesser wand of knock", "lesser wands of knock"),
        copy_from = "spell_wand",
        price_cents = 10000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "knock", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_knock_greater",
        name = ccb.content.plural_text("greater wand of knock", "greater wands of knock"),
        copy_from = "spell_wand",
        price_cents = 15000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "knock", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_improved_knock_minor",
        name = ccb.content.plural_text("minor wand of improved knock", "minor wands of improved knock"),
        copy_from = "spell_wand",
        price_cents = 10000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts improved knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "improved_knock", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_improved_knock_lesser",
        name = ccb.content.plural_text("lesser wand of improved knock", "lesser wands of improved knock"),
        copy_from = "spell_wand",
        price_cents = 15000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts improved knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "improved_knock", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_improved_knock_greater",
        name = ccb.content.plural_text("greater wand of improved knock", "greater wands of improved knock"),
        copy_from = "spell_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with a mana crystal socket at the base that casts a spell when activated.  This wand casts improved knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "improved_knock", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_magic_missile_minor",
        name = ccb.content.plural_text("disposable minor wand of magic missile", "disposable minor wands of magic missile"),
        copy_from = "disp_wand",
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts magic missile."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magic_missile_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_magic_missile_lesser",
        name = ccb.content.plural_text("disposable lesser wand of magic missile", "disposable lesser wands of magic missile"),
        copy_from = "disp_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts magic missile."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magic_missile_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_magic_missile_greater",
        name = ccb.content.plural_text("disposable greater wand of magic missile", "disposable greater wands of magic missile"),
        copy_from = "disp_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts magic missile."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magic_missile_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_fireball_minor",
        name = ccb.content.plural_text("disposable minor wand of fireball", "disposable minor wands of fireball"),
        copy_from = "disp_wand",
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts fireball."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "fireball_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_fireball_lesser",
        name = ccb.content.plural_text("disposable lesser wand of fireball", "disposable lesser wands of fireball"),
        copy_from = "disp_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts fireball."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "fireball_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_fireball_greater",
        name = ccb.content.plural_text("disposable greater wand of fireball", "disposable greater wands of fireball"),
        copy_from = "disp_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts fireball."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "fireball_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_mana_beam_minor",
        name = ccb.content.plural_text("disposable minor wand of mana beam", "disposable minor wands of mana beam"),
        copy_from = "disp_wand",
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts mana beam."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magus_mana_beam_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_mana_beam_lesser",
        name = ccb.content.plural_text("disposable lesser wand of mana beam", "disposable lesser wands of mana beam"),
        copy_from = "disp_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts mana beam."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magus_mana_beam_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_mana_beam_greater",
        name = ccb.content.plural_text("disposable greater wand of mana beam", "disposable greater wands of mana beam"),
        copy_from = "disp_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts mana beam."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "magus_mana_beam_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_point_flare_minor",
        name = ccb.content.plural_text("disposable minor wand of point flare", "disposable minor wands of point flare"),
        copy_from = "disp_wand",
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts point flare."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "point_flare_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_point_flare_lesser",
        name = ccb.content.plural_text("disposable lesser wand of point flare", "disposable lesser wands of point flare"),
        copy_from = "disp_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts point flare."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "point_flare_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_point_flare_greater",
        name = ccb.content.plural_text("disposable greater wand of point flare", "disposable greater wands of point flare"),
        copy_from = "disp_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts point flare."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "point_flare_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_hoaryblast_minor",
        name = ccb.content.plural_text("disposable minor wand of hoary blast", "disposable minor wands of hoary blast"),
        copy_from = "disp_wand",
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts hoary blast."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "hoary_blast_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_hoaryblast_lesser",
        name = ccb.content.plural_text("disposable lesser wand of hoary blast", "disposable lesser wands of hoary blast"),
        copy_from = "disp_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts hoary blast."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "hoary_blast_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_hoaryblast_greater",
        name = ccb.content.plural_text("disposable greater wand of hoary blast", "disposable greater wands of hoary blast"),
        copy_from = "disp_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts hoary blast."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "hoary_blast_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_cone_cold_minor",
        name = ccb.content.plural_text("disposable minor wand of cone of cold", "disposable minor wands of cone of cold"),
        copy_from = "disp_wand",
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts cone of cold."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "cone_cold_wand", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_cone_cold_lesser",
        name = ccb.content.plural_text("disposable lesser wand of cone of cold", "disposable lesser wands of cone of cold"),
        copy_from = "disp_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts cone of cold."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "cone_cold_wand", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_cone_cold_greater",
        name = ccb.content.plural_text("disposable greater wand of cone of cold", "disposable greater wands of cone of cold"),
        copy_from = "disp_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts cone of cold."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "cone_cold_wand", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_knock_minor",
        name = ccb.content.plural_text("disposable minor wand of knock", "disposable minor wands of knock"),
        copy_from = "disp_wand",
        price_cents = 5000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "knock", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_knock_lesser",
        name = ccb.content.plural_text("disposable lesser wand of knock", "disposable lesser wands of knock"),
        copy_from = "disp_wand",
        price_cents = 10000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "knock", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_knock_greater",
        name = ccb.content.plural_text("disposable greater wand of knock", "disposable greater wands of knock"),
        copy_from = "disp_wand",
        price_cents = 15000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "knock", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_improved_knock_minor",
        name = ccb.content.plural_text("disposable minor wand of improved knock", "disposable minor wands of improved knock"),
        copy_from = "disp_wand",
        price_cents = 10000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts improved knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "improved_knock", no_fail = true, level = 5, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_improved_knock_lesser",
        name = ccb.content.plural_text("disposable lesser wand of improved knock", "disposable lesser wands of improved knock"),
        copy_from = "disp_wand",
        price_cents = 20000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts improved knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "improved_knock", no_fail = true, level = 10, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wand_disp_improved_knock_greater",
        name = ccb.content.plural_text("disposable greater wand of improved knock", "disposable greater wands of improved knock"),
        copy_from = "disp_wand",
        price_cents = 30000,
        description = ccb.content.text("A slender wooden wand with an embedded mana crystal at the base that casts a spell when activated.  This wand casts improved knock."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "improved_knock", no_fail = true, level = 15, need_wielding = true }
    item:tool()
    content.add(item)
end
