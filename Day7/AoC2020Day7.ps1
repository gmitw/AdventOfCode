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
  $topLevelBag -match "^((?:\w*\s)*?bag)"
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

$rules = Get-Content .\sample.txt

$ruleObjects = foreach ($rule in $rules) {
  Get-RuleObject -rule $rule
}
$ruleObjects

