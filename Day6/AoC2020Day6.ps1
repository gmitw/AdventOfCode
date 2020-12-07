$declarationForms = Get-Content .\input.txt -Delimiter "$([Environment]::NewLine)$([Environment]::NewLine)"
$sumAny=0
$sumAll=0
foreach ($form in $declarationForms) {
    $sumAny += ($form.ToCharArray() | Where-Object {$_ -match "[a-z]"} |  Select-Object -Unique).count
    $group = $form.Split("`n") | Where-Object {$_ -match "[a-z]"}
    foreach ($char in 97..122) {
        $hasChar =0
        foreach ($passenger in $group) {
            if  ($passenger -match [char] $char) {
                $hasChar ++
            }
        }
        if ($hasChar -eq $group.count) {
            $sumAll++
        } 
    }
}
"Any: $sumAny"
"All: $sumAll"