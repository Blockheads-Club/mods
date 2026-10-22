# Contributing

Thanks for sharing your mod! The steps are in the [README](README.md#-submit-a-mod). In short:

- One pull request per mod. Only change `mods/<first letter>/<id>.toml`.
- New versions go at the end of `[[versions]]`; never edit a published version. To withdraw one, add `yanked = true`.
- `sha256` and `size` must match the file at `url` exactly (`bhmod pack` prints the hash).
- Run the checks yourself before you push: `bhmod check --index my-mod-1.0.0.bhmod`, and for the whole entry
  `bhmod index validate --repo . --base <checkout of main> --author <you> --packages <folder with the .bhmod>`.
- CI comments on the pull request. If it fails, fix the entry or the package and push again.
- Mods that ask for `native`, new permissions, or (new mods) `net-http` wait for a maintainer's security review.

Changes to the tooling, workflows or README: open an issue first. By contributing to this repo you agree that your
entry is released under [CC0-1.0](LICENSE). Your mod itself keeps its own license.
