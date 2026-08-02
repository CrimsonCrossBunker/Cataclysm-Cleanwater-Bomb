# Security policy

## Report privately

Do not open a public issue for a vulnerability that could expose player data,
execute untrusted code, compromise build or release infrastructure, leak a
credential, or provide a practical exploit.

Use GitHub private vulnerability reporting:

<https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/security/advisories/new>

Include:

- affected CCB version, commit, and platform;
- threat model, prerequisites, and impact;
- minimal reproduction or proof of concept;
- relevant logs or stack traces with secrets removed;
- whether the issue is public elsewhere;
- a safe way to contact the reporter.

请不要在公开 Issue 中披露可执行不可信代码、泄露玩家数据或凭据、破坏构建与
发布基础设施的漏洞。请使用 GitHub 私密漏洞报告，并删除附件中的秘密信息。

## Scope

Security reports may cover the current `master` branch, current CCB releases,
bundled code and data, the Lua capability boundary, Android packaging, official
workflows, release artifacts, and CCB-controlled web properties. Third-party
mods, unofficial packages, upstream projects, and unsupported operating-system
components should normally be reported to their owners, but explain any CCB
integration issue.

## Handling

Maintainers will acknowledge and triage reports as capacity permits. We do not
promise a fixed response or release deadline. Please allow maintainers time to
reproduce, coordinate attribution, prepare a fix, and publish an advisory
before public disclosure. Never send credentials; rotate a credential that may
already have been exposed.

Normal crashes and gameplay bugs without a security impact belong in the CCB
bug-report form.
