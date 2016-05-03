Class InvoiceBatchCsvDownload


	'Download all
	Public Function downloadAll()
		dim json
		
		' Create the batch
		call core.api.post("invoicequeue/createbatch","")
		
		' Load the batch that are not downloaded
		call core.log("HERE","HERE")
		set response = core.api.getJSON("invoicequeue/getbatchfordownload","")
		
		
		For Each index In response.data("data")
			Set this = response.data("data").item(index)
			call downloadOne(this)
		Next
	
	End Function
	
	
	'Download one
	Public Function downloadOne(item)

		Dim url: url =  item.item("batch_url") 
		Dim batch_id : batch_id =  item.item("batch_id")
	    Dim file_path : file_path = core.downloader.downloadWithExtension(url,invoice_batch_folder,"csv")
		
		call core.log("INVOICE BATCH ID","Batch ID:"&batch_id)
		
		set fs = CreateObject("scripting.filesystemobject")
		if fs.FileExists(file_path) then 
			
			call core.api.post("invoicequeue/batchstatus","status_id=1&batch_id="&batch_id)
		else
			call core.log("INVOICE BATCH","File not saved")
		end if
		
	
	
	End Function
	
End Class