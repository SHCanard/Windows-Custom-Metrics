# How many of latest applied HotFixes to get
$xLastHF=6

# Enforce culture to US to format correctly DateTime if your culture is different
[System.Threading.Thread]::CurrentThread.CurrentCulture = "en-US"

# Get HotFixes history by installation date descending
Write-Verbose -Message "Get HotFixes history..."
$hotFixes=Get-ComputerInfo | Select-Object -ExpandProperty OsHotFixes | Sort-Object {$_."InstalledOn" -as [DateTime]} -Descending

# If HotFixes are found
if ($hotFixes)
{
# Keep only the X most recent HotFixes
	$hotFixes=$hotFixes | select -First $xLastHF
    echo $hotFixes
}
else
{
	Write-Warning -Message "No HotFixes found!"
	return 1
}
