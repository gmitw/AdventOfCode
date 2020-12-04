function Get-ValidPassport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $Passport
    )
    # $requirements = @("byr:","iyr:","eyr:","hgt:","hcl:","ecl:","pid:") # exclude "cid:" to allow north pole ID"
    $requirements = @("byr:(\d{4})\s+","iyr:(\d{4})\s+", "eyr:(\d{4})\s+","hgt:(\d{2,3})(cm|in)", "hcl:#([a-f]|[0-9]){6}" ,"ecl:(amb|blu|brn|gry|grn|hzl|oth)", "pid:([0-9]){9}")
    $myParameter = [hashtable] @{}
    foreach ($req in $requirements) {
        if ($Passport -match $req) {
            $reqName = $req.Substring(0,$req.IndexOf(":"))
            switch ($reqName) {
                "byr" {
                    if (!([int]$Matches[1] -le 2002 -and [int]$Matches[1] -ge 1920)) {
                        Write-Host "byr out of bounds - " -NoNewline
                        return $null;
                    } else {
                        $myParameter.Add("byr",$Matches[1])
                    }
                }
                "iyr" {
                    if (!([int]$Matches[1] -le 2020 -and [int]$Matches[1] -ge 2010)) {
                        Write-Host "iyr out of bounds - " -NoNewline
                        return $null;
                    }
                }
                "eyr" {  
                    if (!([int]$Matches[1] -le 2030 -and [int]$Matches[1] -ge 2020)) {
                        Write-Host "eyr out of bounds - " -NoNewline
                        return $null;
                    }
                }
               
                "hgt" {
                        if ($Matches[2] -eq "cm") {
                            if ([int]$Matches[1] -lt 150 -or [int]$Matches[1] -gt 193){
                                Write-Host "hgt out of bounds $($Matches[1])(cm) 150-193 - " -NoNewline
                                return $null
                            }
                        } else {
                            if ([int]$Matches[1] -lt 59 -or [int]$Matches[1] -gt 76){
                                Write-Host "hgt out of bounds $($Matches[1])(in) 59-76 - " -NoNewline
                                return $null
                            }
                        }
                }
                "hcl" {
                    break
                }
                "ecl" {
                    break
                }
                "pid" {
                    break
                }
                Default {break}
            }
        } else {
            Write-Host "Missing $req in $Passport" -NoNewline
            return $null
        }
    }
    return $Passport
}

[System.Collections.ArrayList] $content = Get-Content -Path ".\input.txt"
$oneLinePassports = [System.Collections.ArrayList] @{}

$prevNullIndex=0
$finalNullIndex=$content.LastIndexOf("")
do {
    if ($prevNullIndex -lt $finalNullIndex) {
        $nextNullIndex=$content.IndexOf("",$prevNullIndex)
    } else {
        $nextNullIndex=$content.Count-1
    }
    $passport=""
    foreach ($i in $prevNullIndex..$nextNullIndex) {
        $passport += "$($Content[$i]) " 
    }
    [void]$oneLinePassports.Add($passport)
    $prevNullIndex = $nextNullIndex+1
} while ($prevNullIndex -le ($finalNullIndex+1))



$validPassports= [System.Collections.ArrayList] @{}
foreach ($passport in $oneLinePassports) {
    Write-Host "Checking index: $($oneLinePassports.IndexOf($passport) + 1)"
    $result = Get-ValidPassport -Passport $passport
    if ($null -ne $result) {
        $validPassports.Add($result)
    } else {
        Write-Host "index: $($oneLinePassports.IndexOf($passport) + 1)"
    }
}

$validPassports
