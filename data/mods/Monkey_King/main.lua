local ccb = require("ccb")

-- Native enchantments follow mutation ownership, cache rebuilds and saves.
-- Multipliers here are relative changes: 0.20 means +20%, not x0.20.
local strength = ccb.content.Enchantment {
    id = "MONKEY_KING_STRENGTH_BONUS",
    condition = "ALWAYS",
}
strength:value("STRENGTH", { add = 5 })
strength:value("ATTACK_SPEED", { multiply = -0.15 })
strength:value("MELEE_DAMAGE", { multiply = 0.15 })
ccb.content.add(strength)

local might = ccb.content.Mutation {
    id = "MONKEY_KING_MIGHT",
    name = "齐天神力",
    description = "你继承了石猴的神力。力量增加5点，近战攻击耗时降低15%，近战伤害增加15%。未安装合成肺时，额外力量也会增加10点氧气上限。",
    points = 6,
    starting_trait = true,
    valid = false,
    purifiable = false,
    chargen_allow_npc = false,
    random_start_allowed = false,
}
might:relationship("enchantment", strength.id)
ccb.content.add(might)

local resilience = ccb.content.Enchantment {
    id = "MONKEY_KING_BODY_BONUS",
    condition = "ALWAYS",
}
-- Native pre-armor reduction for resistible damage; no_resist types are excluded.
resilience:value("ARMOR_ALL", { multiply = -0.05 })
resilience:value("MAX_HP", { multiply = 0.20 })
resilience:value("REGEN_HP", { multiply = 0.50 })
-- Native awake healing uses (REGEN_HP_AWAKE - 1); +0.25 enables slow healing.
resilience:value("REGEN_HP_AWAKE", { add = 0.25 })
resilience:value("MAX_STAMINA", { multiply = 0.25 })
resilience:value("REGEN_STAMINA", { multiply = 0.25 })

local body = ccb.content.Mutation {
    id = "MONKEY_KING_DIAMOND_BODY",
    name = "金刚猿躯",
    ugliness = -4, -- Same native appearance contribution as BEAUTIFUL.
    description = "你的身躯坚韧而轻灵，容貌俊美，拥有与「美丽」相同的外貌加成。受到的可抵抗伤害在护甲结算前降低5%（纯粹等不可抵抗伤害除外）。全身获得3点钝击、3点斩击和2点刺击防护，另有3点火焰、寒冷、电击及酸蚀防护，可抵御相应元素法术伤害；不抵御所有法术或状态效果。生命上限增加20%，累赘降低15%，基础生命恢复速度增加50%，清醒时也能缓慢恢复。耐力上限与耐力恢复速度各增加25%。",
    points = 6,
    starting_trait = true,
    valid = false,
    purifiable = false,
    chargen_allow_npc = false,
    random_start_allowed = false,
}

-- Cover all twelve standard human body parts, including eyes, hands and feet.
local bodyparts = {
    "head", "eyes", "mouth", "torso",
    "arm_l", "arm_r", "hand_l", "hand_r",
    "leg_l", "leg_r", "foot_l", "foot_r",
}
for _, part in ipairs(bodyparts) do
    body:armor(part, "bash", 3)
    body:armor(part, "cut", 3)
    body:armor(part, "stab", 2)
    for _, element in ipairs({ "heat", "cold", "electric", "acid" }) do
        body:armor(part, element, 3)
    end
    resilience:encumbrance(part, { multiply = -0.15 })
end
ccb.content.add(resilience)
body:relationship("enchantment", resilience.id)
ccb.content.add(body)


-- Each optional inheritance owns its enchantment; no automatic trait grants.
local function add_inheritance(id, name, description, points, bonuses)
    local enchantment = ccb.content.Enchantment {
        id = id .. "_BONUS",
        condition = "ALWAYS",
    }
    for _, bonus in ipairs(bonuses) do
        enchantment:value(bonus[1], bonus[2])
    end
    ccb.content.add(enchantment)
    local mutation = ccb.content.Mutation {
        id = id,
        name = name,
        description = description,
        points = points,
        starting_trait = true,
        valid = false,
        purifiable = false,
        chargen_allow_npc = false,
        random_start_allowed = false,
    }
    mutation:relationship("enchantment", enchantment.id)
    ccb.content.add(mutation)
end

add_inheritance("MONKEY_KING_GOLDEN_EYES", "火眼金睛",
    "你的目光锐利，能在昏暗中辨清事物。感知增加3点，原生夜视范围参数增加3；特殊夜视装备或能力可能覆盖这项夜视加成。不能透视墙壁。", 3, {
        { "PERCEPTION", { add = 3 } },
        { "NIGHT_VIS", { add = 3 } },
    })

add_inheritance("MONKEY_KING_CLOUD_STEP", "筋斗身法",
    "你身形灵动，落地轻盈。敏捷增加2点，移动耗时降低10%，原生坠落伤害修正降低30%。仍会受坠落伤害，不能飞行。", 3, {
        { "DEXTERITY", { add = 2 } },
        { "MOVE_COST", { multiply = -0.10 } },
        { "FALL_DAMAGE", { multiply = -0.30 } },
    })

add_inheritance("MONKEY_KING_WATER_ADEPT", "水行猿息",
    "你善于在水中划行，也懂得在缠斗中节省体力。游泳耗时修正降低25%，近战耐力消耗降低15%。仍须换气，不提供水下呼吸。", 2, {
        { "MOVECOST_SWIM_MOD", { multiply = -0.25 } },
        { "MELEE_STAMINA_CONSUMPTION", { multiply = -0.15 } },
    })

add_inheritance("MONKEY_KING_ENLIGHTENED_MIND", "灵台慧根",
    "你心思通明，悟性出众。智力增加2点，用于学习的有效专注提高20%，不直接补满专注或授予技能。", 3, {
        { "INTELLIGENCE", { add = 2 } },
        { "LEARNING_FOCUS", { multiply = 0.20 } },
    })

require("profession")
