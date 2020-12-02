$passwords = Get-Content .\input.txt
$total = 0

foreach ($pass in $passwords) {
    $index = $pass.split(" ").split("-")
    $min = $index[0]
    $max = $index[1]
    $letter = $index[2][0]
    $word = $index[3]

<# Part 1

    $charCount = ($word.ToCharArray() | Where-Object {$_ -eq $letter}).Count

    if ($charCount -ge $min -And $charCount -le $max) {
        $total++
    }
#>

$word = $word.ToCharArray()
if ($word[$min-1] -eq $letter -xor $word[$max-1] -eq $letter){
    $total++
}

}
Write-Host $total