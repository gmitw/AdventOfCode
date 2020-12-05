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

$myCol=-1
$myRow=-1
$mySeatId=-1
Write-Host "Highest SeatId is $maxSeatId"
foreach ($seatID in $minSeatID..$maxSeatID) {
    if ($locations.SeatID -notcontains $seatID -and $locations.SeatId -contains ($seatID-1) -and $locations.SeatId -contains ($seatID+1)) {
        Write-Host "My SeatId is $seatId"
        $myRow = ($locations | Where-Object SeatId -eq ($seatID-1)).Row
        $myCol = ($locations | Where-Object SeatId -eq ($seatID-1)).Col+1
        if ($myCol -gt 7) {
            $myCol=0
            $myRow++
        }
        $mySeatId = $seatID
    }
}



Write-Host "     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |"
Write-Host "-----+-----+-----+-----+-----+-----+-----+-----+-----+"

foreach ($row in (0..127)) {
    $numSpaces = 3 - ([String]$row).Length
    foreach ($space in 0..$numSpaces) {
        Write-Host " " -NoNewline
    }
    Write-Host "$row |" -NoNewline

    foreach ($col in 0..7) {
        $currentSeatID = ($locations | Where-Object Col -eq $col | Where-Object Row -eq $row).SeatId
        $magenta=$false
        if ($row -eq $myRow -and $col -eq $myCol) {
            $currentSeatID = $mySeatId
            $magenta=$true
        }
        $numSpaces = 3 - ([String]$currentSeatID).Length
        foreach ($space in 0..$numSpaces) {
            Write-Host " " -NoNewline
        }
        if ($magenta) {
            Write-Host "$currentSeatID " -NoNewline -ForegroundColor Magenta
            Write-Host "|" -NoNewline
        } else {
            Write-Host "$currentSeatID |" -NoNewline
        }
    }
    Write-Host ""
}