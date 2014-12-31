#Powershell script to retrieve permissions of specific network shares and diffs them.  Then outputs to CSV for Splunk
#BLieberman , 6/30/14

####SANITZIED###
#paths have been replaced with placeholder variables

#Setup array with our paths
$PathArray= @("$path1", "$path2", "$pathx")

#need this because having slashes in filenames is bad 
$iter=0 

foreach ($path in $PathArray)
{

 $previous="$dir_" + $iter + ".csv"
 $current="$dir_" + $iter + ".csv"
 
#if "init" is passed as param, init the previous file and quit
 if($args[0] -eq "init")
 {
  Get-Acl -path $path | Select-Object -ExpandProperty Access | export-csv -notype $previous
	Write-Host "Initialized!"
	$iter += 1
	continue
	}
 

 
#get updates 
 Get-Acl -path $path | Select-Object -ExpandProperty Access | export-csv -notype $current
 
#check difs 
 $dif =  Compare-Object -ReferenceObject (Get-Content $previous) -DifferenceObject (Get-Content $current) -IncludeEqual

#output to file, detect add/remove
foreach ($difference in $dif)
{
	
	if($difference.SideIndicator -eq "=>")
	{
	$difference.InputObject + ",`"Add`"" + ",`"$path`"" >> $dir\output\diffs.csv
	
	}
	
	if($difference.SideIndicator -eq "<=")
	{
	$difference.InputObject + ",`"Remove`"" + ",`"$path`"" >> $dir\output\diffs.csv
	}
	




}
#move current to previous and delete previous
Remove-Item $previous
Rename-Item $current $previous 
	$iter += 1
}