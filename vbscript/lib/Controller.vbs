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
				case else 
					call core.log("ROUTE","Route not found")
			End Select
			
			
	End Function
	
	
	
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