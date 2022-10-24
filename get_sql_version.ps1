# Get MSSQL version
Write-Verbose -Message "Get SQL version..."
$FullVersion=Invoke-Sqlcmd -Query "SELECT @@VERSION;" -QueryTimeout 3

# If Version is found
if ($FullVersion)
{
# Do some cleanup of the output
	$SplitedOnSpace=($FullVersion | Select-Object -ExpandProperty Column1 | Out-String).Trim().Split(" ")
  $SplitedOnParenthesis=$SplitedOnSpace[4].Split("()")  
    
# Display if not empty
	if ($SplitedOnSpace)
	{
		echo "Major version: "
		$SplitedOnSpace[3]
	}
	else
	{
		Write-Warning -Message "No major version entry"
		return 1
	}
	
# Display if not empty
	if ($SplitedOnParenthesis)
	{
		echo "CU version: "
		$SplitedOnParenthesis[1]
	}
	else
	{
		Write-Warning -Message "No CU version entry"
		return 1
	}
  
}
else
{
	Write-Warning -Message "No SQL version found!"
	return 1
}
