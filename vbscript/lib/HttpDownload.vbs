Class HttpDownload


Function download(url,path)

	download =  downloadWithExtension(url,path,"")

End Function

	Function downloadWithExtension( url, path, ext )
	
	    ' Standard housekeeping
	    Dim i, objFile, objFSO, objHTTP, strFile, strMsg
	    Const ForReading = 1, ForWriting = 2, ForAppending = 8
	
	    ' Create a File System Object
	    Set objFSO = CreateObject( "Scripting.FileSystemObject" )
	
	   ' Check if the specified target file or folder exists,
		' and build the fully qualified path of the target file
		If objFSO.FolderExists( path ) Then
			strFile = objFSO.BuildPath( path, Mid( url, InStrRev( url, "/" ) + 1 ) )
		ElseIf objFSO.FolderExists( Left( path, InStrRev( path, "\" ) - 1 ) ) Then
			strFile = path
		Else
			WScript.Echo "ERROR: Target folder not found."
			Exit Function
		End If

		if ext<>"" then
			strFile = strFile&"."&ext
		end if
		
		
	
	    ' Create or open the target file
	    Set objFile = objFSO.OpenTextFile( strFile, ForWriting, True )
	
	    ' Create an HTTP object
	    Set objHTTP = CreateObject( "WinHttp.WinHttpRequest.5.1" )
	
	    ' Download the specified URL
	    objHTTP.Open "GET", url, False
	    objHTTP.Send
	
	    ' Write the downloaded byte stream to the target file
	    For i = 1 To LenB( objHTTP.ResponseBody )
	        objFile.Write Chr( AscB( MidB( objHTTP.ResponseBody, i, 1 ) ) )
	    Next
	
	    ' Close the target file
	    objFile.Close( )
		call core.log("Downloaded File",url&" -----> "&strFile)
		downloadWithExtension = strFile
	End Function

End Class