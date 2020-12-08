function Get-RuleObject {
  [CmdletBinding()]
  param (
      [Parameter()]
      [String]
      $rule
  )
  $topLevelBag, $subLevel = $rule.Split("contain")
  $subLevelList = $subLevel.Split(",") 

  $myProperty= [hashtable]@{}
  if ($topLevelBag -match "^((?:\w*\s)*?)bag") {
    $myProperty.Add("TopLevelBag", $Matches[1])
    $containedBags = foreach ($bagType in $subLevelList) {
      if ($bagType -match "(\d+)\s((?:\w*\s)*?)bag") {

        $mySubProperty = [hashtable] @{}
        $mySubProperty.Add("Quantity",$Matches[1])
        $mySubProperty.Add("Color",$Matches[2])
        $myObj = New-Object -TypeName psobject -Property $mySubProperty
        $myObj
      }
    }
    $myProperty.Add("ContainedBags",$containedBags)
    $myRuleObj = New-Object -TypeName psobject -Property $myProperty
    return $myRuleObj
  }
}

function Get-PathToShinyGold {
  [CmdletBinding()]
  param (
      [Parameter()]
      [String]
      $TopLevelBag,
      [Parameter()]
      [psobject]
      $ruleObjects
  )
  $colors = $ruleObjects | Where-Object TopLevelBag -eq $TopLevelBag | Select-Object -ExpandProperty ContainedBags | Select-Object Color
  # Write-Host "$TopLevelBag Contains"
  # Write-Host $colors 


  if ($null -eq $colors) {
    return $false
  } elseif ($colors.Color.trim() -contains "shiny gold"){
    return $true
  } 
  # else {
  #   foreach ($color in $colors.Color) {
  #     if (Get-PathToShinyGold -TopLevelBag $color -ruleObjects $ruleObjects) {
  #       return $true
  #     }
  #   }
    return $false
  # }
}

function  Get-UpperLevel {
  [CmdletBinding()]
  param (
      [Parameter()]
      [String]
      $Color
  )
  $UpperLevel = $ruleObjects | Where-OBject { $_.ContainedBags.Color -match $Color }
}

$rules = Get-Content -path rules.txt
$ruleObjects = foreach ($rule in $rules) {
  Get-RuleObject -rule $rule
}
$ruleObjects | Where-OBject {$_.ContainedBags.Color -match "striped gold"}


# $sum=0
# $ruleNum=1
# foreach ($rule in $ruleObjects) {
#   Clear-Host
#   "There are $($ruleObjects.count) rules."
#   "Checking rule: $ruleNum"
#   $ruleNum++
#   "Paths to Shiny Gold: $sum"
#   $hasPath = Get-PathToShinyGold -TopLevelBag $rule.TopLevelBag -ruleObjects $ruleObjects
#   if ($hasPath){
#     $sum++
#   }
# }

