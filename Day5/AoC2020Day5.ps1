function Get-SeatLocation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $BinarySpace
    )
    $boardingPass = $BinarySpace.ToCharArray()
    $maxRow = 127
    $minRow = 0
    $leftCol = 0
    $rightCol = 7
    foreach ($c in $boardingPass) {
        switch ($c) {
            'F' {
                $maxRow-= (($minRow..$maxRow).count/2)
            }
            'B' {
                $minRow+= (($minRow..$maxRow).count/2)
            }
            'L' {
                $rightCol-= (($leftCol..$rightCol).Count/2)
            }
            'R' {
                $leftCol+= (($leftCol..$rightCol).Count/2)
            }
        }
    }
    $property = [hashtable] @{}
    $property.Add('Row',$minRow)
    $property.Add('Col',$leftCol)
    $sID = ($minRow * 8) + $leftCol
    $property.Add('SeatId',[int] $sID)
    $myObj = New-Object -TypeName psobject -Property $property
    return $myObj
}
    
$boardingPasses = Get-Content -Path .\input.txt
$locations = $boardingPasses | ForEach-Object { Get-SeatLocation -BinarySpace $_ }
$maxSeatID = ($locations | Sort-Object SeatId | Select-Object -Last 1).SeatID
$minSeatID = ($locations | Sort-Object SeatId | Select-Object -First 1).SeatID

Write-Host "Highest SeatId is $maxSeatId"
foreach ($seatID in $minSeatID..$maxSeatID) {
    if ($locations.SeatID -notcontains $seatID -and $locations.SeatId -contains ($seatID-1) -and $locations.SeatId -contains ($seatID+1)) {
        Write-Host "My SeatId is $seatId"
    }
}
