Class Controller

	' Request of the route
	Public Function routeRequest()
			
			
	
			if(Wscript.Arguments.count()=0) then 
				call core.log("ROUTE","Please pass a route")
				exit Function
			end if
			
			Dim route: route =  WScript.Arguments(0)
			
			Select Case route 
				case "invoice_download"
					call routeInvoiceDownload()
				
				case "invoice_batch_csv_download"
					call routeInvoiceBatchCsvDownload()
					
				case "csv_report"
					call routeCsvReport()
				case else 
					call core.log("ROUTE","Route not found")
			End Select
			
			
	End Function
	
	Public Sub routeCsvReport
	
		if  WScript.Arguments.count <3 then 
				call core.log("Error","Pass the report tag and path in the window")
				exit Sub
		end if

		
		call core.Import("CSVDownload") 
		call core.log("ROUTE","Routing to csv_report")
		set queue = new CSVDownload
		call queue.download(WScript.Arguments(1), WScript.Arguments(2))
	
	End Sub
	
	
	
	' Invoice CSV download
	Public Sub routeInvoiceBatchCsvDownload()
	
		' Import requiremetns
		call core.Import("InvoiceBatchCsvDownload")
		call core.log("ROUTE","Routing to invoice_batch_csv_download")
		set queue = new InvoiceBatchCsvDownload
		call queue.downloadAll()
	
	End Sub 
	
	
	' Invoice download
	Public Sub routeInvoiceDownload()
	
		' Import requiremetns
		call core.Import("InvoiceQueue")
			call core.log("ROUTE","Routing to invoice_download")
		set queue = new InvoiceQueue 
		call queue.downloadAll()
	
	End Sub 
	

End Class