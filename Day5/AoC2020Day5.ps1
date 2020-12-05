function Get-SeatLocation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $BoardingPass
    )
    $maxRow = 127
    $minRow = 0
    $leftCol = 0
    $rightCol = 7
    foreach ($c in $BoardingPass.ToCharArray()) {
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
    $myProperties = [hashtable] @{}
    $myProperties.Add('Row',$minRow)
    $myProperties.Add('Col',$leftCol)
    $seatID = ($minRow * 8) + $leftCol
    $myProperties.Add('SeatId',[int] $seatID)
    $myObj = New-Object -TypeName psobject -Property $myProperties
    return $myObj
}
    
$boardingPasses = Get-Content -Path .\input.txt
$locations = $boardingPasses | ForEach-Object { Get-SeatLocation -BoardingPass $_ }
$maxSeatID = ($locations | Sort-Object SeatId | Select-Object -Last 1).SeatID
$minSeatID = ($locations | Sort-Object SeatId | Select-Object -First 1).SeatID

Write-Host "Highest SeatId is $maxSeatId"
foreach ($seatID in $minSeatID..$maxSeatID) {
    if ($locations.SeatID -notcontains $seatID -and $locations.SeatId -contains ($seatID-1) -and $locations.SeatId -contains ($seatID+1)) {
        Write-Host "My SeatId is $seatId"
    }
}
