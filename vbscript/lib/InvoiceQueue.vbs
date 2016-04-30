Class InvoiceQueue


	'Download all
	Public Function downloadAll()
		dim json
		set response = core.api.getJSON("invoicequeue/getmailqueue","")
		
		
		
		
		For Each index In response.data("data")
			Set this = response.data("data").item(index)
			call downloadOne(this)
		Next
	
	End Function
	
	'Download one
	Public Function downloadOne(item)
	
		Dim url: url =  item.item("invoice_url") 
		Dim queue_id : queue_id =  item.item("queue_id")
		Dim file_path : file_path = core.downloader.downloadWithExtension(url,invoice_download_path,"pdf")
		
		call core.log("INVOICE DOWNLOAD","Queue ID:"&queue_id)
	
		set fs = CreateObject("scripting.filesystemobject")
		if fs.FileExists(file_path) then 
			
			call core.api.post("invoicequeue/queuestatus","status_id=1&queue_id="&queue_id)
		else
			call core.log("INVOICE","File not saved")
		end if
		
	
	
	End Function
	
End Class