# Build and verify the thesis

1. Run `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-latex.ps1` from the repository root.
2. If compilation fails, inspect the first actionable error in `build/main.log`; fix the source rather than generated files.
3. Re-run the build until it exits successfully.
4. Confirm that `build/main.pdf` exists and report any remaining LaTeX warnings separately from errors.
