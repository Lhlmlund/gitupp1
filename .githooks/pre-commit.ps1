# Pre-commit hook för filstorlekskontroll
$maxSize = 1MB
$exitCode = 0

# Hämta ändrade filer
$files = git diff --cached --name-only
foreach ($file in $files) {
    if (Test-Path $file -PathType Leaf) {
        $size = (Get-Item $file).Length
        if ($size -gt $maxSize) {
            Write-Host "Error: $file is larger than 1MB ($([math]::Round($size / 1MB, 2)) MB)" -ForegroundColor Red
            $exitCode = 1
        }
    }
}

if ($exitCode -eq 0) {
    Write-Host "All files are smaller than 1MB" -ForegroundColor Green
}
exit $exitCode