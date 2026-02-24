property consultationKinds : Collection
property titles : Collection


shared singleton Class constructor
	This.titles:=New shared collection(""; "Mr"; "Mrs"; "Ms")
	
	
	// MARK: Titles
Function titles_getPupMenu($code : Integer)->$chosenCode : Integer
	var $i : Integer
	var $refMenu; $title; $choose : Text
	
	$refMenu:=Create menu
	$i:=0
	For each ($title; This.titles)
		APPEND MENU ITEM($refMenu; $title; *)
		SET MENU ITEM PARAMETER($refMenu; -1; String($i))
		If ($code=$i)
			SET MENU ITEM MARK($refMenu; -1; Char(18))
		End if 
		$i+=1
	End for each 
	
	$choose:=Dynamic pop up menu($refMenu)
	If ($choose#"")
		$chosenCode:=Num($choose)
	Else 
		$chosenCode:=$code
	End if 
	RELEASE MENU($refMenu)
	
	
	// MARK: Consultation Kind
Function _consultationKinds_load()
	If (This.consultationKinds=Null)
		ds.ConsultationKind.cacheLoad()
	End if 
	
Function consultationKind_get($uuid : Text)->$ck : Object
	This._consultationKinds_load()
	$ck:=This.consultationKinds.query("UUID = :1"; $uuid).first()
	
Function consultationKind_getPupMenu($uuid_CK : Text)->$chosenUUID : Text
	var $refMenu; $choose : Text
	var $consultationKind : Object
	
	This._consultationKinds_load()
	
	$refMenu:=Create menu
	
	For each ($consultationKind; This.consultationKinds)
		APPEND MENU ITEM($refMenu; $consultationKind.name; *)
		SET MENU ITEM PARAMETER($refMenu; -1; $consultationKind.UUID)
		If ($uuid_CK=$consultationKind.UUID)
			SET MENU ITEM MARK($refMenu; -1; Char(18))
		End if 
	End for each 
	
	$choose:=Dynamic pop up menu($refMenu)
	If ($choose#"")
		$chosenUUID:=$choose
	End if 
	RELEASE MENU($refMenu)
	