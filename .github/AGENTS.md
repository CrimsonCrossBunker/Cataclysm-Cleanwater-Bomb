# `.github/` agent instructions

- Workflows are authoritative build and validation contracts.
- Pin third-party actions to full commit SHAs and grant minimum permissions.
- Treat PR titles, bodies, labels, and fork input as untrusted data.
- Stage documentation-impact enforcement through `ai/docs-impact.yml`; require
  a mapping only after its docs and default-branch checks are complete.
- Repository settings described by `ai/repository-settings.target.yml` are a
  target and manual checklist, not proof that settings are active.

CI 修改应使用最小权限并固定第三方 Action；不得把目标配置描述成已经生效。
