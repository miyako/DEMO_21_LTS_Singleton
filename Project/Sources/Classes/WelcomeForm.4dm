Class constructor
	
Function openPatients($formEventCode : Integer)
	
	var $window : Integer
	Case of 
		: ($formEventCode=On Clicked)
			$window:=Open form window("PatientsList"; Plain form window)
			DIALOG("PatientsList"; *)
	End case 
	
Function openAppointmentWizard($formEventCode : Integer)
	
	var $window : Integer
	Case of 
		: ($formEventCode=On Clicked)
			$window:=Open form window("AppointmentWizard"; Plain form window)
			DIALOG("AppointmentWizard"; *)
	End case 