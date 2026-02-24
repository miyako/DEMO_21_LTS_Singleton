property patients : cs.PersonSelection
property currentPatient : cs.PersonEntity
property selectedPatients : Collection

Class constructor
	
	// Load all tasks ordered by due date
	This.patients:=ds.Person.all().orderBy("firstName, lastName asc")
	This.currentPatient:=Null
	This.selectedPatients:=[]
	
Function formMethod()
	This.redrawObjects()
	
	
Function refreshList($formEventCode : Integer)
	
	Case of 
		: ($formEventCode=On Clicked)
			This.patients:=ds.Person.all().orderBy("firstName, lastName asc")
			This.currentPatient:=Null
			This.selectedPatients:=[]
	End case 
	
Function pupMenuTitle($formEventCode : Integer)
	Case of 
		: ($formEventCode=On Clicked)
			var $title : Text
			
			If (Form.currentPatient#Null)
				//Create pop up menu
				Form.currentPatient.titleCode:=cs.CacheManager.me.titles_getPupMenu(Form.currentPatient.titleCode)
				//POST KEY(Tab)
			End if 
	End case 
	
Function saveCurrentPatient()
	var $info : Object
	If (Form.currentPatient#Null)
		$info:=Form.currentPatient.save()
	End if 
	
Function redrawObjects()
	OBJECT SET ENABLED(*; "BtnSave"; (Form.currentPatient#Null))
	OBJECT SET ENTERABLE(*; "Input_@"; (Form.currentPatient#Null))
	OBJECT SET ENABLED(*; "Input_@"; (Form.currentPatient#Null))
	If (Form.currentPatient#Null)
		OBJECT SET RGB COLORS(*; "Input_@"; "black"; "#D7DEED")
	Else 
		OBJECT SET RGB COLORS(*; "Input_@"; "black"; "#E9E9E9")
	End if 