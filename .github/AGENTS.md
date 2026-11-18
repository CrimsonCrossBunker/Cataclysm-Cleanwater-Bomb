# `.github/` agent instructions

- Workflows are authoritative build and validation contracts.
- Pin third-party actions to full commit SHAs and grant minimum permissions.
- Treat PR titles, bodies, labels, and fork inputs as untrusted data.
- Stage doc-impact checks via `ai/docs-impact.yml`; treat `ai/repository-settings.target.yml` as a target checklist, not live state.
