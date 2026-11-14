<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Archiving in progress / 归档中**
>
> Stable document ID / 稳定文档 ID: `archive.firearms-massachusetts-data-workflow`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/archive/firearms/massachusetts-data-workflow/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/archive/firearms/massachusetts-data-workflow/
> Archiving start date / 开始归档日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> 全文是针对 2004–2023 马萨诸塞州 CSV 的一次性 sqlite/sed 清洗笔记，引用的 fix_serial_numbers.sql 与 remove_empty_entroes.sql 未被 Git 跟踪，也不是游戏构建或数据契约。
> This in-repository body is retained as historical reference while archive organization is still in progress. No deletion deadline is set. The content may reflect older upstream lore, proposals, or processes and does not represent current CCB lore, implementation, or policy. Additions or corrections should identify differences from the historical content. The body will serve as a reference for later archive organization. Any removal requires a separate review and an explicit maintainer decision; neither dates nor status changes authorize deletion.
> 本仓库正文暂作为历史参考保留，归档整理尚未完成，暂不设置删除期限。内容可能反映旧上游设定、方案或流程，不代表当前 CCB 的设定、实现或规则。如需补充或纠错，应注明与历史内容的区别。正文将作为后续归档与整理的参考来源；是否移除正文应另行复核，由维护者明确决定，不因日期或状态变化自动删除。
<!-- CCB-DOC-MOVED-END -->
These instructions are built around pretty standard linux command line tools, plus sqlite3 and moreutils.

First, retrieve the .csv files from https://www.mass.gov/info-details/data-about-firearms-licensing-and-transactions
You want both 'Download: Firearms Dealer Transactions <date range>' and 'Download: Personal Transfers and Registrations - <date range>'

Translate the date fields to ISO-8601 like so `sed "s_\([^/,]*\)/\([^/,]*\)/\([^/,]*\),\(.*\)_20\3-\1-\2,\4_g" 01.01.23-12.31.23.csv`

Remove frst line from all but the first sales csv like so
tail -2 01.01.09-12.31.21.iso.date.csv | sponge 01.01.09-12.31.21.iso.date.csv
tail -2 01.01.22-12.31.22.iso.date.csv | sponge 01.01.22-12.31.22.iso.date.csv
tail -2 01.01.23-12.31.23.iso.date.csv | sponge 01.01.23-12.31.23.iso.date.csv

Create a database, add a table like so:

Import each file into the database like so:
.mode csv
.import personal_transactions.iso.date.csv personal_transactions
.import 01.01.04-12.31.08.iso.date.csv sales
.import 01.01.09-12.31.21.iso.date.csv sales
.import 01.01.22-12.31.22.iso.date.csv sales
.import 01.01.23-12.31.23.iso.date.csv sales

Filter and rename the personal transactions columns while copying into a new table like so:
CREATE TABLE gun_data AS SELECT "TRANSACTION DATE" as date, "BUYER STATE" as state, MAKE as make, MODEL as model, TYPE as type, "SERIAL NUMBER" as serial, "WEAPON SIZE" as ammo_type FROM personal_transactions;

Filter and rename the sales columns while coping into the just created table like so:
INSERT INTO gun_data SELECT "DATE OF TRANSACTION" as date, "BUYER STATE" as state, MAKE as make, MODEL as model, "WEAPON TYPE" as type, "SERIAL NUMBER" as serial, "WEAPON SIZE" as ammo_type FROM sales;

Drop the intermediate tables.
DROP TABLE sales;
DROP TABLE personal_transactions;
VACUUM;
Possibly save and reload the database here?

Run "script" to deduplicate the "not available" values for serial number.
.read fix_serial_numbers.sql
Run "script" to remove empty lines
.read remove_empty_entroes.sql

Deduplicate rows with matching serial fields, with latest date winning.
CREATE INDEX gun_data_idx_deduplication_query ON gun_data(serial, date);
DELETE FROM gun_data WHERE rowid IN (SELECT q1.rowid from gun_data q1 JOIN gun_data q2 on q1.serial = q2.serial WHERE q1.serial != "NONE" AND q1.date < q2.date);
DROP INDEX IF EXISTS gun_data_idx_deduplication_query;

Remove rows with a state field not equal to MA
DELETE FROM gun_data WHERE state != "MA" AND state != "";

Now you're ready to start fixing data entry errors.
From this point on we don't use the date and state fields.

Basically we have a big list of incorrectly spelled values for particular fields along with the correct spelling.
Then we have a script that will spit out SQL statements to make these substitutions happen.
