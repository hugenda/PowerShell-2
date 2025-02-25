# The send-tcp.ps1 PowerShell Script

## Synopsis & Description
```powershell
send-tcp.ps1 [<target-IP>] [<target-port>] [<message>]
```

Sends a TCP message to the given IP address and port.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/send-tcp.ps1 [[-TargetIP] <String>] [[-TargetPort] <Int32>] [[-Message] <String>] [<CommonParameters>]
```

```
-TargetIP <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-TargetPort <Int32>
    
    Required?                    false
    Position?                    2
    Default value                0
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-Message <String>
    
    Required?                    false
    Position?                    3
    Default value                
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
PS>.\send-tcp.ps1 192.168.100.100 8080 "TEST"
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated by convert-ps2md.ps1 using the comment-based help of send-tcp.ps1*
