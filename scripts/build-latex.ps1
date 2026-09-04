$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$buildDir = Join-Path $projectRoot "build"
$mainFile = Join-Path $projectRoot "main.tex"

if (-not (Test-Path -LiteralPath $mainFile)) {
    throw "Cannot find main.tex at $mainFile"
}

New-Item -ItemType Directory -Force -Path $buildDir | Out-Null
Set-Location -LiteralPath $projectRoot

# Antigravity may have been opened before MiKTeX was installed, so its terminal
# can still have the old PATH. Discover the standard per-user install without
# reintroducing a machine-specific username into the repository.
if (-not (Get-Command pdflatex -ErrorAction SilentlyContinue)) {
    $localPrograms = [Environment]::GetFolderPath("LocalApplicationData")
    $miktexBin = Join-Path $localPrograms "Programs\MiKTeX\miktex\bin\x64"
    if (Test-Path -LiteralPath (Join-Path $miktexBin "pdflatex.exe")) {
        $env:PATH = "$miktexBin;$env:PATH"
    }
}

if ((Get-Command latexmk -ErrorAction SilentlyContinue) -and (Get-Command perl -ErrorAction SilentlyContinue)) {
    & latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf "-outdir=$buildDir" $mainFile
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
} else {
    foreach ($command in @("pdflatex", "bibtex")) {
        if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
            throw "Missing '$command'. Install MiKTeX or TeX Live, add its bin directory to PATH, then restart Antigravity."
        }
    }

    & pdflatex -synctex=1 -interaction=nonstopmode -file-line-error "-output-directory=$buildDir" $mainFile
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    & bibtex (Join-Path $buildDir "main")
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    1..2 | ForEach-Object {
        & pdflatex -synctex=1 -interaction=nonstopmode -file-line-error "-output-directory=$buildDir" $mainFile
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    }
}

Write-Host "Built $buildDir\main.pdf"
