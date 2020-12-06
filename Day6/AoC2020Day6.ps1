$declarationForms = Get-Content .\input.txt -Delimiter "$([Environment]::NewLine)$([Environment]::NewLine)"
$sum=0
foreach ($form in $declarationForms) {
    $sum += ($form.ToCharArray() | Where-Object {$_ -match "[a-z]"} |  Select-Object -Unique).count
}
$sum