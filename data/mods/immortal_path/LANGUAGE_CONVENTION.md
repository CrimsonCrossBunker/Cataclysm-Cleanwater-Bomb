# 灾变仙路 — 初期语言约定 / Language Convention (Early Stage)

> 本文档约定 mod 开发初期的文本写法。**待主仓库 i18n 翻译落地后，按本文末尾的迁移步骤快速切换为正式 i18n。**
> This document defines the text-writing convention for the early development stage. Once upstream i18n lands, migrate per the steps at the bottom.

## 背景 / Background

主仓库（Cataclysm-DDA）的正式做法是：JSON 里只写英文（`en_US`），中文等其它语言通过 `.po` 翻译文件提供，由游戏在运行时按区域设置查找。

但在本 mod 早期开发阶段，主仓库的翻译流程尚未对本 mod 的字符串落地。为了让中文玩家/开发者能直接看到中文、同时不丢失未来的英文原文，我们采用 **「中文为主、英文注释」** 的临时写法。

Upstream practice: JSON holds only English (`en_US`); other languages come from `.po` files looked up at runtime. During this mod's early stage, that pipeline isn't wired up yet — so we temporarily write **Chinese as the live value, English as a comment**.

## 写法约定 / Writing Convention

所有面向玩家的可翻译字段（`name`、`description`、`name_plural`、`use_action.msg`、对话文本等），都按下面的成对写法：

For every player-facing translatable field, write it as a pair:

```jsonc
{
  "name": "聚气丹",
  "//en_us_name": "Qi-Gathering Pill",
  "description": "服下后能温养丹田，加速引气入体。",
  "//en_us_description": "Once swallowed, it nourishes the dantian and speeds the drawing of qi into the body."
}
```

### 规则 / Rules

1. **可翻译字段的「值」直接写中文。** 这样游戏里立刻显示中文，无需翻译流程。
   The *value* of a translatable field is written in Chinese directly, so it shows in-game immediately.

2. **紧跟一行 `//en_us_<字段名>`，值为对应英文原文。** CDDA 的 JSON 解析器会忽略所有以 `//` 开头的键，因此这是安全的注释。
   Follow with a `//en_us_<fieldname>` key holding the English. CDDA's JSON parser ignores any key starting with `//`, so this is a safe comment.

3. **键名规则**：`//en_us_` + 原字段名。
   - `name` → `//en_us_name`
   - `description` → `//en_us_description`
   - `name_plural` → `//en_us_name_plural`
   - 嵌套字段（如 `use_action.msg`）就近放一个 `//en_us_msg`。
   Key = `//en_us_` + original field name. For nested fields, place `//en_us_<leaf>` next to it.

4. **非翻译字段不要加英文注释**（如 `id`、`weight`、`volume`、`type` 等本身就是英文/数值的字段）。
   Don't annotate non-translatable fields (`id`, `weight`, `type`, numbers, etc.).

5. **`id` 永远用英文 snake_case，且确定后不要改**，因为它被存档和其它 JSON 引用。
   `id` is always English snake_case and must stay stable — it's referenced by saves and other JSON.

6. 英文注释力求是「可直接当作 en_US 原文使用」的质量，迁移时能直接搬过去。
   Aim for English comments good enough to drop straight into en_US at migration time.

## 迁移到正式 i18n / Migration to Proper i18n

待主仓库翻译流程对本 mod 字符串落地后，按以下步骤切换（建议写脚本批量处理）：

Once upstream i18n is wired up, switch as follows (a script is recommended):

1. **互换值**：把每个翻译字段的「值」替换为对应 `//en_us_<字段>` 注释里的英文原文。
   Swap: replace each translatable field's value with the English from its `//en_us_<field>` comment.

2. **删除注释**：移除所有 `//en_us_*` 键。
   Delete all `//en_us_*` keys.

3. **导出 `.po`**：用主仓库的字符串提取工具生成 `*.pot`，原先的中文值作为 `msgstr` 录入中文 `.po`（`zh_CN`）。
   Extract strings to `*.pot` and enter the former Chinese values as `msgstr` in the `zh_CN` `.po`.

4. **验证**：英文环境显示英文，中文环境显示中文，无遗漏字符串。
   Verify: English locale shows English, Chinese locale shows Chinese, no missing strings.

> 因为每条中文都成对保留了英文原文，迁移基本是机械操作，可脚本化、低风险。
> Because every Chinese string keeps its English pair, migration is mechanical, scriptable, and low-risk.

## 翻译字段速查 / Translatable Fields Cheat Sheet

常见需要成对写法的字段（非穷尽）：
Common fields needing the pair convention (non-exhaustive):

- 物品/家具/地形/怪物：`name`、`name_plural`、`description`
- 法术 / spell：`name`、`description`、`message`、`sound_description`
- 变异 / mutation：`name`、`description`
- 对话 / talk_topic：`dynamic_line`、`response.text`
- use_action / 各类动作消息：`msg`、`menu_text`、`activation_message` 等
- 成就 / 任务：`name`、`description`、`text`
