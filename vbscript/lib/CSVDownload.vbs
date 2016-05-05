Class CSVDownload


	'Download all
	Public Function download(tag, path)
		dim json
		
		set response = core.api.getJSON("csvsqlreport/getreportname","report_tag="&tag)
		set attributes = response.data("attributes")
		
		Dim name: name = attributes.item("name")
		call core.log("FILENAME",name)
		
		
		dim method: method = "csvsqlreport/download"
		dim url: url = api_end_point&method&"?__token="&api_token&"&report_tag="&tag
		
		
		
		call core.downloader.downloadWithFullPath(url, path&"/"&name)	
	
	End Function

	
End Class