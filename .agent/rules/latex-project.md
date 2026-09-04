# LaTeX thesis project rules

- Treat `main.tex` as the root document and `build/main.pdf` as the generated artifact.
- Chapter source files live in `Chapter/`; references live in `refs.bib`; images live in `img/`.
- Preserve UTF-8 Vietnamese text. Never change file encoding or normalize Vietnamese characters unless explicitly requested.
- Keep generated LaTeX files out of source control. Build output belongs in `build/`.
- After editing LaTeX, run `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-latex.ps1` and inspect the compiler output for errors.
- Prefer small, localized edits. Do not rewrite thesis prose, citations, labels, or formatting outside the requested scope.
- When adding citations, use an existing key from `refs.bib` or add a complete BibTeX entry and cite its key.
- When adding figures, use repository-relative paths and include a caption plus a stable `fig:` label.
- When adding tables, include a caption plus a stable `tab:` label and keep the layout within `\textwidth`.
