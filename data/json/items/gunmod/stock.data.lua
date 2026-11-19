local ccb = require("ccb")

ccb.content.define_item {
    id = "adjustable_stock",
    name = ccb.content.plural_text("adjustable stock", "adjustable stocks"),
    description = ccb.content.text("An adjustable replacement stock improving both recoil and accuracy."),
    mass = "350 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "380 USD",
    survival_price = "5 USD",
    accuracy = 1,
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    melee_damage = { bash = 6 },
    gunmod = {
        install_time = "10 m",
        location = ccb.content.text("stock"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        dispersion_modifier = -1,
        handling_modifier = 1,
    },
}

ccb.content.define_item {
    id = "folding_stock",
    name = ccb.content.plural_text("folding stock", "folding stocks"),
    description = ccb.content.text("A folding stock which reduces length when folded.  Currently unfolded and ready to shoot."),
    mass = "200 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "420 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You fold the stock for transport."),
            menu_text = ccb.content.text("Fold"),
            target = "folding_stock_folded",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 3 } },
}

-- 10 is the modifier that stocked weapons normally get, and due to unbalance from having it folded it's a greater malus.
ccb.content.define_item {
    id = "folding_stock_folded",
    name = ccb.content.plural_text("folding stock (folded)", "folding stocks (folded)"),
    description = ccb.content.text("A folding stock which reduces length.  Currently folded, making shooting this gun difficult."),
    copy_from = "folding_stock",
    flags = { "FOLDED_STOCK" },
    gunmod = { handling_modifier = -15 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You unfold the stock for combat."),
            menu_text = ccb.content.text("Unfold"),
            target = "folding_stock",
            moves = 120,
        },
    },
}

-- benefits of adjustable stock
ccb.content.define_item {
    id = "high_end_folding_stock",
    name = ccb.content.plural_text("adjustable folding stock", "adjustable folding stocks"),
    description = ccb.content.text("A multi position, high-end folding stock which reduces length when folded.  Currently unfolded and ready to shoot."),
    mass = "200 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "420 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        dispersion_modifier = -1,
        handling_modifier = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You fold the stock for transport."),
            menu_text = ccb.content.text("Fold"),
            target = "high_end_folding_stock_folded",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 3 } },
}

-- 10 is the modifier that stocked weapons normally get, and due to unbalance from having it folded it's a greater malus.
ccb.content.define_item {
    id = "high_end_folding_stock_folded",
    name = ccb.content.plural_text("adjustable folding stock (folded)", "adjustable folding stocks (folded)"),
    description = ccb.content.text("A multi position, high-end folding stock which reduces length when folded.  Currently folded, making shooting this gun hard."),
    copy_from = "high_end_folding_stock",
    flags = { "FOLDED_STOCK" },
    gunmod = { dispersion_modifier = 0, handling_modifier = -15 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You unfold the stock for combat."),
            menu_text = ccb.content.text("Unfold"),
            target = "high_end_folding_stock",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "wire_stock",
    name = ccb.content.plural_text("collapsing wire stock", "collapsing wire stocks"),
    description = ccb.content.text("A collapsing wire stock which folds closely against the body of the weapon, reducing length and volume."),
    mass = "170 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "300 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = ":",
    color = "dark_gray",
    flags = { "IRREMOVABLE" },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = {
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You push the stock in for storage."),
            menu_text = ccb.content.text("Fold"),
            target = "wire_stock_folded",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 3 } },
}

-- 10 is the modifier that stocked weapons normally get, but due to it being inline it has no imbalance malus..
ccb.content.define_item {
    id = "wire_stock_folded",
    name = ccb.content.plural_text("collapsing wire stock (collapsed)", "collapsing wire stocks (collapsed)"),
    description = ccb.content.text("A collapsing wire stock which folds closely against the body of the weapon, reducing length and volume.  Currently collapsed, making shooting difficult."),
    copy_from = "wire_stock",
    flags = { "COLLAPSED_STOCK", "IRREMOVABLE" },
    gunmod = { handling_modifier = -10 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You pull the stock out for combat."),
            menu_text = ccb.content.text("Unfold"),
            target = "wire_stock",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "stock_mauser",
    name = ccb.content.plural_text("Mauser C96 stock", "Mauser C96 stocks"),
    description = ccb.content.text("The hollow removable wooden pistol stock of the C96 Mauser pistol, which doubles as a holster.  It fits both the original clip-loaded C96 and later magazine-fed reproductions, but a gun with an extended magazine won't fit without modification."),
    copy_from = "pistol_stock",
    volume = "700 ml",
    integral_volume = "700 ml",
    integral_mass = "590 g",
    integral_length = "35 cm",
    mass = "590 g",
    materials = { "wood" },
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            rigid = true,
            allowed_items = { "mauser_c96" },
            capacity = "650 ml",
            mass_limit = "1815 g",
            max_item_length = "32 cm",
            moves = 50,
        },
    },
    flags = { "BELTED", "BELT_CLIP", "OVERSIZE" },
    subtype_order = { "armor", "gunmod" },
    armor = {
        portions = {
            {
                materials = { { id = "wood", thickness = 5 } },
                encumbrance = { 3, 4 },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    gunmod = {
        location = ccb.content.text("stock mount"),
        targets = { ccb.content.text("mauser_c96", "gun_type_type") },
    },
    use_actions = { { kind = "holster" } },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- though the stock isn't COLLAPSED it is functionally the same
ccb.content.define_item {
    id = "stock_none",
    name = ccb.content.plural_text("sawn-off stock", "sawn-off stocks"),
    description = ccb.content.text("A quick saw cut removed the original stock from this weapon.  It is now much harder to handle, but much smaller."),
    materials = { "wood" },
    symbol = ":",
    color = "dark_gray",
    flags = { "REMOVED_STOCK", "IRREMOVABLE" },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock mount"),
        handling_modifier = -10,
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
        },
        to_hit_modifier = -1,
    },
}

ccb.content.define_item {
    id = "pistol_stock",
    name = ccb.content.plural_text("pistol stock", "pistol stocks"),
    description = ccb.content.text("An add-on stock for handguns, this considerably improves control of recoil."),
    mass = "350 g",
    volume = "500 ml",
    integral_length = "30 cm",
    integral_volume = "500 ml",
    integral_mass = "350 g",
    price = "380 USD",
    survival_price = "5 USD",
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = { ccb.content.text("pistol", "gun_type_type") },
        handling_modifier = 6,
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "recoil_stock",
    name = ccb.content.plural_text("recoil stock", "recoil stocks"),
    description = ccb.content.text("A replacement stock designed to absorb perceived recoil."),
    mass = "960 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "4 USD",
    survival_price = "5 USD",
    accuracy = 1,
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    melee_damage = { bash = 6 },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        handling_modifier = 4,
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "cheek_pad",
    name = ccb.content.plural_text("cheek pad", "cheek pads"),
    description = ccb.content.text("A stock accessory for sniper rifles and DMRs, this considerably improves eye relief efficiency, prevents slipping, and reduces recoil to the neck and cheek."),
    mass = "300 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    integral_mass = "300 g",
    price = "45 USD",
    survival_price = "5 USD",
    accuracy = 1,
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    melee_damage = { bash = 2 },
    gunmod = {
        install_time = "3 m",
        location = ccb.content.text("stock accessory"),
        targets = { ccb.content.text("rifle", "gun_type_type") },
        dispersion_modifier = -1,
        handling_modifier = 2,
    },
    minimum_skills = { { id = "weapon", count = 2 } },
}

ccb.content.define_item {
    id = "butt_hook",
    name = ccb.content.plural_text("butt hook", "butt hooks"),
    description = ccb.content.text("An attachment to the butt of the gun that is held under the armpit, improving stability."),
    mass = "100 g",
    volume = "100 ml",
    integral_length = "4 cm",
    integral_volume = "100 ml",
    integral_mass = "100 g",
    price = "47 USD 50 cent",
    survival_price = "50 cent",
    materials = { "aluminum" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        location = ccb.content.text("stock accessory"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
        },
        install_time = "10 m",
        dispersion_modifier = -15,
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- When we get 'rate of angular change' a version for rifles and crossbow can be added.  Currently it would be too strong
-- this seems to be for hooking the gun on your arm not actually folding it up for storage
ccb.content.define_item {
    id = "tail_hook_stock",
    name = ccb.content.plural_text("tail hook stock", "tail hook stocks"),
    description = ccb.content.text("A foldable add-on stock for handguns and submachine guns with a pivoting hook that latches onto the forearm, allowing for greater stability."),
    mass = "150 g",
    volume = "200 ml",
    integral_volume = "0 L",
    price = "50 USD",
    survival_price = "3 USD",
    materials = { "aluminum" },
    symbol = ":",
    color = "dark_gray",
    flags = { "NEEDS_UNFOLD" },
    gunmod = {
        location = ccb.content.text("stock"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("slingshot", "gun_type_type"),
        },
        install_time = "5 m",
        dispersion_modifier = -20,
        handling_modifier = 4,
    },
    minimum_skills = { { id = "weapon", count = 3 } },
}

ccb.content.define_item {
    id = "under_folding_stock",
    name = ccb.content.plural_text("under folding stock", "under folding stocks"),
    description = ccb.content.text("A light wire-framed stock with a push button release catch on the side, which allows it to fold and be stored away under the weapon's receiver.  The wire construction means that it's less comfortable to shoulder than a regular fixed attachment.  The stock is currently locked in the open position."),
    mass = "100 g",
    volume = "300 ml",
    integral_volume = "100 ml",
    integral_mass = "100 g",
    price = "420 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You push in the release catch on the side and fold away the stock."),
            menu_text = ccb.content.text("Fold"),
            target = "under_folding_stock_folded",
            moves = 120,
        },
    },
    minimum_skills = { { id = "weapon", count = 3 } },
}

ccb.content.define_item {
    id = "under_folding_stock_folded",
    name = ccb.content.plural_text("under-folding stock (folded)", "under-folding stocks (folded)"),
    description = ccb.content.text("A light wire-framed stock with a push button release catch on the side  which allows it to fold and be stored away under the weapon's receiver.  It is currently folded underneath the weapon's chassis, making it more difficult to control."),
    copy_from = "under_folding_stock",
    flags = { "FOLDED_STOCK" },
    gunmod = { handling_modifier = -10 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You unfold the stock for combat."),
            menu_text = ccb.content.text("Unfold"),
            target = "under_folding_stock",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "sub2000_folding_mechanism",
    name = ccb.content.plural_text("integral folding mechanism", "integral folding mechanisms"),
    description = ccb.content.text("The integral series of hinges and pivots which allow the SUB-2000 to fold in half and be stored for transport.  The firearm is currently locked in the unfolded position and is ready for use."),
    mass = "10 g",
    volume = "10 ml",
    integral_length = "35 cm",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = { ccb.content.text("ksub2000", "gun_type_type") },
        modes = { { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You tug down on the trigger guard whilst swinging the barrel assembly up and over onto the receiver, locking it into place by the buttplate."),
            menu_text = ccb.content.text("Fold"),
            target = "sub2000_folding_mechanism_folded",
            moves = 300,
        },
    },
    minimum_skills = { { id = "weapon", count = 3 } },
}

-- This mod shouldn't get a folding stock flag. The deployed version of this mod adds extra length to the base gun item, which this folded version removes to simulate the greatly shorter length of the sub2000 when collapsed. Adding a folding stock flag will remove another 20 cm from the base gun, making it only 19 cm long.
ccb.content.define_item {
    id = "sub2000_folding_mechanism_folded",
    name = ccb.content.plural_text("integral folding mechanism (folded))", "integral folding mechanisms (folded)"),
    description = ccb.content.text("The integral series of hinges and pivots which allow the SUB-2000 to fold in half and be stored for transport.  Shooting this firearm would be particularly tricky given that the barrel assembly is folded and locked backwards for storage, rendering the weapon inoperable."),
    mass = "10 g",
    volume = "10 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = { ccb.content.text("ksub2000", "gun_type_type") },
        modes = {
            {
                id = "DEFAULT",
                label = ccb.content.text("disabled"),
                quantity = 0,
                flags = { "MELEE" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You release the barrel and pivot it forwards, locking it in the open firing position."),
            menu_text = ccb.content.text("Unfold"),
            target = "sub2000_folding_mechanism",
            moves = 300,
        },
    },
}

ccb.content.define_item {
    id = "m26_mass_stock",
    name = ccb.content.plural_text("MASS compatible stock", "MASS compatible stocks"),
    description = ccb.content.text("A specially designed adjustable stock with an integrated grip to convert the M26-MASS to a standalone configuration."),
    mass = "960 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "4 USD",
    survival_price = "5 USD",
    accuracy = 1,
    materials = { "plastic", "steel" },
    symbol = ":",
    color = "dark_gray",
    melee_damage = { bash = 4 },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = { ccb.content.text("m26_mass_standalone", "gun_type_type") },
        handling_modifier = 4,
    },
    minimum_skills = { { id = "shotgun", count = 2 } },
}

ccb.content.define_item {
    id = "scout_stock",
    name = ccb.content.plural_text("hollow polymer stock", "hollow polymer stocks"),
    description = ccb.content.text("An extremely lightweight stock.  There's a hollow cavity at the bottom where a spare magazine can be stored."),
    mass = "260 g",
    volume = "500 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "4 USD",
    survival_price = "5 USD",
    accuracy = 1,
    materials = { "plastic" },
    symbol = ":",
    color = "dark_gray",
    melee_damage = { bash = 3 },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("stock"),
        targets = { ccb.content.text("steyr_scout", "gun_type_type") },
        added_pockets = {
            {
                kind = "CONTAINER",
                rigid = true,
                allowed_items = { "steyr_scout_mag", "steyr_scout_mag_makeshift" },
                capacity = "200 ml",
                mass_limit = "200 g",
            },
        },
    },
}
