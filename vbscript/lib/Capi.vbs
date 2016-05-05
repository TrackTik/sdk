Class Capi

	'@Property MSXML2.XMLHTTP
	Public http
	
	
	
	' Open connection 
	Private Sub Class_Initialize
		set http = CreateObject("MSXML2.XMLHTTP")		
	End Sub

	' Echo request
	Public Function testConnection()
		call post("echo/testconnection","")
	End Function

	' Post a payload
	Public Function post (method, payload)
		Dim url
		url = api_end_point&method&"?__token="&api_token
		http.open "POST",url,false 
		call http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		core.log "CAPI", url

		http.send payload
		
		core.log "CAPI Response", http.responseText 

	End Function 
	
	' Post a payload
	Public Function getRaw (method, payload)
		Dim url
		url = api_end_point&method&"?__token="&api_token
		http.open "POST",url,false 
		call http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		
		core.log "CAPI", url
		http.send payload
		getRaw = http.responseText
		
		
		
	End Function 
	
	' Post a payload
	Public Function getJSON (method, payload)
		Dim url
		url = api_end_point&method&"?__token="&api_token
		
		http.open "POST",url,false 
		call http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		
		http.send payload
		call core.log("RAW",http.responseText)
		
		
		set response = new VbJson
		response.init()
		call response.loadJSON(http.responseText)
		set getJSON = response
		
		
		
	End Function 



	' Encode params
	Function urlEncode(ByVal str)
		Dim strTemp, strChar
		Dim intPos, intASCII, newstr
		strTemp = ""
		strChar = ""
	 
		' no values
		if  isNull(str) then 
			urlEncode = ""
			exit function
		end if
	 
		'Strip trailing spaces
		newstr = Rtrim(str)
		For intPos = 1 To Len(newstr)
			intASCII = Asc(Mid(newstr, intPos, 1))
			If intASCII = 32 Then
				strTemp = strTemp & "+"
			ElseIf ((intASCII < 123) And (intASCII > 96)) Then
				strTemp = strTemp & Chr(intASCII)
			ElseIf ((intASCII < 91) And (intASCII > 64)) Then
				strTemp = strTemp & Chr(intASCII)
			ElseIf ((intASCII < 58) And (intASCII > 47)) Then
				strTemp = strTemp & Chr(intASCII)
			Else
				strChar = Trim(Hex(intASCII))
				If intASCII < 16 Then
					strTemp = strTemp & "%0" & strChar
				Else
					strTemp = strTemp & "%" & strChar
				End If
			End If
		Next
		urlEncode = strTemp

		End Function

End Class