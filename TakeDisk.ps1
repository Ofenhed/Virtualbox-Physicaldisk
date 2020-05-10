$disks = Get-Disk | Where-Object {$_.OperationalStatus -eq 'Offline'}

foreach ($disk in $disks) {

    $physical = "\\.\PHYSICALDRIVE{0:d}" -f $disk.Number

    Write-Output $physical

    $aclObject = [io.directory]::GetAccessControl($physical)

    $me = Get-LocalUser marcu

    $newrule = New-Object System.Security.AccessControl.FileSystemAccessRule $me,"FullControl","Allow"

    Write-Output $newrule

    $aclObject.SetAccessRule($newrule)

    [io.directory]::SetAccessControl($physical,$aclObject)

    Write-Output $aclObject

}