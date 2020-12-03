function Get-TreesForSlope {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]
        $down,
        [Parameter(Mandatory)]
        [int]
        $right
    )
        $content = Get-Content -Path C:\powershell\AoC\2020\Day3\input.txt
        $x=0
        $trees=0
        for ($y = 0; $y -lt $content.Count; $y+=$down) {    
            if ($x -gt ($content[$y].Length-1)) {
                $x-= ($content[$y].Length)
            }
            if (($content[$y].ToCharArray())[$x] -eq "#") {
                $trees++
            }
            $x+=$right
        }
        return $trees
    }
    $slope1 = Get-TreesForSlope -right 1  -down 1
    $slope2 = Get-TreesForSlope -right 3  -down 1 
    $slope3 = Get-TreesForSlope -right 5  -down 1
    $slope4 = Get-TreesForSlope -right 7  -down 1
    $slope5 = Get-TreesForSlope -right 1  -down 2
    
    $total = $slope1*$slope2*$slope3*$slope4*$slope5
    $total
    