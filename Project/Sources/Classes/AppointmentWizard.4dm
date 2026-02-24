property UUID_ConsultationKind : Text
property patient : cs.PersonEntity
property searchPatients : cs.PersonSelection
property firstName; lastName; UUID_Person : Text

Class constructor
	
	
	
Function redraw()
	var $patient : cs.PersonEntity
	
	If (Form.UUID_ConsultationKind=Null) || (Form.UUID_ConsultationKind="")
		OBJECT SET TITLE(*; "Pup_consultationKind"; "Select a consultation kind")
	Else 
		OBJECT SET TITLE(*; "Pup_consultationKind"; cs.CacheManager.me.consultationKind_get(Form.UUID_ConsultationKind).name)
	End if 
	
	
	OBJECT SET VISIBLE(*; "pup_person"; (Form.searchPatients#Null))
	If (Form.UUID_Person#Null) && (Form.UUID_Person#"") && (Form.UUID_Person#("0"*32))
		$patient:=ds.Person.get(Form.UUID_Person)
		Form.lastName:=$patient.lastName
		Form.firstName:=$patient.firstName
	Else 
		Form.lastName:=""
		Form.firstName:=""
	End if 
	
Function searchPatientsByFirstName()
	var $patients : cs.PersonSelection
	var $patient : cs.PersonEntity
	var $search : Text
	
	Case of 
		: (FORM Event.code=On Data Change)
			
			$search:=Form.firstName+"@"
			
			Form.searchPatients:=ds.Person.query("firstName = :1"; $search)
			If (Form.searchPatients.length>0)
				$patient:=Form.searchPatients.first()
				Form.lastName:=$patient.lastName
				Form.firstName:=$patient.firstName
				Form.UUID_Person:=$patient.UUID
			Else 
				Form.UUID_Person:="0"*32
			End if 
			This.redraw()
			
	End case 
	
Function searchPatientsByLastName()
	var $patients : cs.PersonSelection
	var $patient : cs.PersonEntity
	var $search : Text
	
	Case of 
		: (FORM Event.code=On Data Change)
			
			$search:=Form.lastName+"@"
			
			Form.searchPatients:=ds.Person.query("firstName = :1"; $search)
			If (Form.searchPatients.length>0)
				$patient:=Form.searchPatients.first()
				Form.lastName:=$patient.lastName
				Form.firstName:=$patient.firstName
				Form.UUID_Person:=$patient.UUID
			Else 
				Form.UUID_Person:="0"*32
			End if 
			This.redraw()
			
	End case 
	
Function pupPatient()
	var $patient : cs.PersonEntity
	var $menu; $choose : Text
	
	$menu:=Create menu()
	
	For each ($patient; Form.searchPatients)
		APPEND MENU ITEM($menu; $patient.firstName+" "+$patient.lastName)
		SET MENU ITEM PARAMETER($menu; -1; $patient.UUID)
	End for each 
	
	$choose:=Dynamic pop up menu($menu)
	RELEASE MENU($menu)
	
	
	Case of 
		: ($choose="")
		: ($choose#"")
			Form.UUID_Person:=$choose
			This.redraw()
	End case 