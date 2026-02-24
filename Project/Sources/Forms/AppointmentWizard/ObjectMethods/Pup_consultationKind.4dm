var $choose : Text

$choose:=cs.CacheManager.me.consultationKind_getPupMenu(Form.UUID_ConsultationKind)
If ($choose#"")
	Form.UUID_ConsultationKind:=$choose
	Form.redraw()
End if 
