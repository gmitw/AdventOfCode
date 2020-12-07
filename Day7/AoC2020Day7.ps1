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
  if ($topLevelBag -match "^((?:\w*\s)*?bag)") {
    $myProperty.Add("TopLevelBag", $Matches[0])
    $containedBags = foreach ($bagType in $subLevelList) {
      if($bagType -match "(\d+)\s((?:\w*\s)*?bag)") {

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
      $TopLevelBag
  )
  $colors = $ruleObjects | Where-Object TopLevelBag -eq $TopLevelBag | Select-Object -ExpandProperty ContainedBags | Select-Object Color
  if ($null -eq $colors) {
    return $false
  } elseif ($colors.Color.trim() -contains "shiny gold bag"){
    return $true
  } else {
    foreach ($color in $colors.Color.trim()) {
      return Get-PathToShinyGold -TopLevelBag $color
    }
  }
}

$rules = Get-Content .\rules.txt

$ruleObjects = foreach ($rule in $rules) {
  Get-RuleObject -rule $rule
}
$ruleObjects.count
$sum=0
$paths=1
foreach ($TopLevelBag in $ruleObjects.TopLevelBag) {
Clear-Host
"There are $($ruleObjects.count) Rule Objects"
"Paths to Shiny Gold Bag: $sum"
"Paths checked: $paths"
  if (Get-PathToShinyGold -TopLevelBag $TopLevelBag) {
    $sum++
  }
  $paths++
}
"Done!"