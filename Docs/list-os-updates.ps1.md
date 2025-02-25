# The list-os-updates.ps1 PowerShell Script

## Synopsis & Description
```powershell
list-os-updates.ps1 [<RSS-URL>] [<max-count>]
```

Lists the latest operating system updates.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/list-os-updates.ps1 [[-RSS_URL] <String>] [[-MaxCount] <Int32>] [<CommonParameters>]
```

```
-RSS_URL <String>
    
    Required?                    false
    Position?                    1
    Default value                https://distrowatch.com/news/dwd.xml
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-MaxCount <Int32>
    
    Required?                    false
    Position?                    2
    Default value                20
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
[<CommonParameters>]
    This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

## Example
```powershell
PS>.\list-os-updates.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated by convert-ps2md.ps1 using the comment-based help of list-os-updates.ps1*
