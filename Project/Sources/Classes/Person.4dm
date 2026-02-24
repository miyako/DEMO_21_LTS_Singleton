Class extends DataClass


Function personAge30()->$res : cs.PersonSelection
	$res:=This.query("age >= :1"; 30)
	
Function personAge50()->$res : cs.PersonSelection
	$res:=This.query("age >= :1"; 50)
	
Function appointmentToday()->$res : cs.PersonSelection
	$res:=This.query("appointments.date= :1"; Current date())
	
Function lessonToday()->$res : cs.PersonSelection
	$res:=This.query("privateLessons.date= :1"; Current date())
	
	