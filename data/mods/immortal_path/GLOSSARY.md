# 术语表 / Glossary

> **本表是全 mod 中英对照的唯一权威来源。**
> 所有游戏内 JSON 的 `//en_us_*` 注释（见 [LANGUAGE_CONVENTION](LANGUAGE_CONVENTION.md)）从本表取英文译名，保持全 mod 一致。
> 新增术语先在此登记，再用于 JSON。

## 境界 / Realms

| 中文 | en_US | 备注 |
|------|-------|------|
| 修仙 / 修炼 | cultivation | 动词/名词通用 |
| 修士 / 修行者 | cultivator | |
| 境界 | realm | 大境界 |
| 小层 | minor stage | 大境界内分层 |
| 突破 | breakthrough | 升大境界事件 |
| 瓶颈 | bottleneck | |
| 炼气 | Qi Refining | 境界 1 |
| 筑基 | Foundation Establishment | 境界 2 |
| 金丹 | Golden Core | 境界 3 |
| 元婴 | Nascent Soul | 境界 4 |
| 化神 | Spirit Severing | 境界 5 |
| 飞升 | ascension | 远期叙事 |

## 灵气与修炼 / Qi & Cultivation

| 中文 | en_US | 备注 |
|------|-------|------|
| 灵气 | qi | 核心资源；独立 vitamin 能量池（非原版 mana） |
| 灵气复苏 | the Qi Awakening | 灾变=灵气复苏 |
| 末法之世 | the Age of Ending Law | 复苏前的灵气枯竭时代 |
| 引气入体 | drawing qi into the body | 入门动作 |
| 吐纳 / 打坐 | qi breathing / meditation | 吸纳环境灵气 |
| 灵根 | spirit root | 修炼天赋；幸存=有灵根 |
| 灵根品质 | spirit root grade | |
| 五行（金木水火土） | the Five Phases (metal, wood, water, fire, earth) | 五行属性 |
| 丹田 | dantian | 灵气储藏 |
| 神识 | spirit sense | 元婴境探测 |
| 辟谷 | inedia | 免食机制术语 |
| 走火入魔 | qi deviation | 突破/急修反噬（事件性） |
| 元婴出窍 | nascent soul projection | |
| 心神疲惫 | mental fatigue | 连续打坐累积，压低打坐经验（session 级、会恢复） |

## 功法与神通 / Techniques & Arts

| 中文 | en_US | 备注 |
|------|-------|------|
| 功法 | cultivation technique | 总称 |
| 心法 / 主修功法 | core method | 被动主修 |
| 法术 | art | 主动能力，无门槛、凡引气入体者皆可学；底层用 SPELL |
| 秘术 | secret art | 须先修特定功法、记于其秘籍方可习练 |
| 神通 | innate art | 由功法自动衍生、不可主动学习而直接获得 |
| 御物 | telekinesis | 隔空操物 |
| 御剑 | flying sword | 御剑飞行/攻击 |
| 残卷 / 玉简 / 传承 | scroll / jade slip / legacy | 功法来源 |
| 灵气强度 | qi power | 攻击/破坏类法术威力的绝对评判标准之一；境界/装备抬升；enchant 通道 qi_power，基础 100 |
| 属性极化 | (phase) polarization | 法术属性偏向乘数；功法/装备抬升；enchant 通道 polarization_*，基础 1 |
| 火弹术 | Fireball | 火行入门攻击法术（无门槛）；威力 = 基础 × 灵气强度系数 × 火行极化 |
| 寒泉迸 | Cold-Spring Burst | 水行入门攻击法术（无门槛）；威力 = 基础 × 灵气强度系数 × 水行极化；damage_type cold |
| 葳蕤经（木） | Sutra of Verdant Flourishing | 练气期木行功法 |
| 炎阳真传（火） | Blazing Sun Transmission | 练气期火行功法 |
| 磐石篇（土） | The Bedrock Chapter | 练气期土行功法 |
| 素锋录（金） | Record of the Bared Edge | 练气期金行功法 |
| 玄渊心法（水） | Abyssal Heart Method | 练气期水行功法 |
| 血煞炼尸功（魔） | Blood-Fiend Corpse Refining | 练气期魔功；涉尸体血液 |
| 养荣导引 | Nourishing Guidance | 葳蕤经吐纳法门 |
| 炼焰息 | Flame-Tempering Breath | 炎阳真传吐纳法门 |
| 镇岳吐纳 | Mountain-Pressing Breath | 磐石篇吐纳法门 |
| 淬锋诀 | Edge-Quenching Method | 素锋录吐纳法门 |
| 纳川息 | River-Gathering Breath | 玄渊心法吐纳法门 |
| 摄血息 | Blood-Drawing Breath | 血煞炼尸功吐纳法门 |
| 草木同春（木·载体特性） | One Spring with All Things | 修木行所成之体 |
| 阳炎附骨（火·载体特性） | Yang-Flame in the Marrow | 修火行所成之体 |
| 不动如山（土·载体特性） | Unmoving as the Mountain | 修土行所成之体 |
| 百炼成锋（金·载体特性） | A Hundred Temperings to an Edge | 修金行所成之体 |
| 渊渟（水·载体特性） | Still as the Deep | 修水行所成之体 |
| 血煞侵髓（魔·载体特性） | Blood-Fiend in the Marrow | 修魔功所成之体 |
| 葳蕤木灵丹 | Verdant Wood-Spirit Pill | 葳蕤经配套疗伤丹 |

## 物品与生物 / Items & Creatures

| 中文 | en_US | 备注 |
|------|-------|------|
| 灵材 | spirit material | 修炼材料总称 |
| 妖丹 | demon core | 妖兽内丹 |
| 炼化（灵材） | refine (material) | 炼化灵材回灵气 |
| 灵植 | spirit plant | 被灵气催化的植物 |
| 妖兽 | demon beast | 被灵气催化的兽 |
| 丹药 | elixir / pill | 炼丹产物 |
| 炼丹 | alchemy | |
| 炼器 | artifact forging | 炼制法器 |
| 法器 / 法宝 | magic tool / treasure | 修士器物 |
| 洞府 | cave abode | 修士居所/据点 |
| 聚气丹 | Qi-Gathering Pill | 基础回灵丹药 |

## 势力 / Factions（预留）

| 中文 | en_US | 备注 |
|------|-------|------|
| 宗门 | sect | |
| 隐世宗门 | hidden sect | 灾变前隐世者 |
| 邪修 | demonic cultivator | 行邪道、不择手段者 |
| 散修 | rogue cultivator | 无门无派，玩家默认 |

## 登记规范 / How to Add Terms

1. 新术语先加进对应分类表（中文 + en_US + 备注）。
2. JSON 里写 `"name": "<中文>"` + `"//en_us_name": "<en_US>"`，英文严格照本表。
3. 译名拿不准时先在备注标 `〔暂译〕`，待定稿；定稿后去掉标记。
4. 同一概念全 mod 只用一个译名，避免 Golden Core / Gold Pellet 混用。
