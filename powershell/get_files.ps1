<#
  if you need to get a list of a lot of files, use this
#>

$Files = Get-ChildItem $RootFolder -Recurse -Force -OutBuffer 1000
