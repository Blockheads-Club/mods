<!-- One mod per pull request. Only change mods/<first letter>/<id>.toml. -->

**Mod:** `<id>` — new mod / new version / yank

- [ ] The package was built with `bhmod pack` and passes `bhmod check --index`.
- [ ] `url` is a permanent link; `sha256` and `size` match that file.
- [ ] The package contains a `LICENSE`, and its `mod.toml` matches this entry.
- [ ] I only added versions at the end (or added `yanked = true`).
- [ ] The mod asks only for the permissions it needs. If it uses `native` or `net-http`, I explain why below.
- [ ] New mod or new permissions: I know a maintainer reads the code before merge (security review), and the
      source is public at `repo`.

**What it does / why it needs its permissions:**
