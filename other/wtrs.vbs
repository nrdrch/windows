On Error Resume Next
Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run "taskkill /im WindowsTerminal.exe /f", 0, True
Do While ProcessRunning("WindowsTerminal.exe")
    WScript.Sleep 1000
Loop
intReturnCode = objShell.Run("wt", 1, True)
If intReturnCode <> 0 Then
    WScript.Echo "Error: Unable to start Windows Terminal"
    WScript.Quit 1
End If
Function ProcessRunning(processName)
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = '" & processName & "'")
    ProcessRunning = (colProcesses.Count > 0)
End Function
