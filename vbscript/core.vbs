

' TrackTik Script Librairies for windows. 
' Setup settings with your 
Class TrackTikCore

	'@Property HttpDowload
	Dim downloader
	
	'@Property Capi
	Dim api
	
	'@Property VbsJson
	Dim json

	'@Property Controller
	Dim router
	
	' Init
	Function Init()
		
		Import("../settings")
		Import("HttpDownload")
		Import("Capi")
		Import("VbJson")
		Import("Controller")
	
		
		Set downloader = New HttpDownload
		Set router = New Controller
		Set api = New Capi
		Set json = New VbJson
		json.init()
		
		
	End Function

	' Import a sub library
	Public Function Import(file)
		Dim gsLibDir : gsLibDir = ".\lib\"
		Dim goFS     : Set goFS = CreateObject("Scripting.FileSystemObject")

		file = file&".vbs"
		ExecuteGlobal goFS.OpenTextFile(goFS.BuildPath(gsLibDir, file)).ReadAll() 
	End Function
	
	Public Sub log(cat,details)
		wscript.echo cat&"	"&details
	End Sub
	

End Class


dim core :  set core = New TrackTikCore
core.init()
call core.router.routeRequest()




