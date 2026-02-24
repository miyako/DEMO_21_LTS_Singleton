Class extends DataClass




//MARK:- Cache Management
local Function cacheClear()
	If (cs.CacheManager.me.consultationKinds#Null)
		Use (cs.CacheManager.me)
			cs.CacheManager.me.consultationKinds:=Null
		End use 
	End if 
	
local Function cacheLoad()
	var $consultationKindColl : Collection
	
	If (cs.CacheManager.me.consultationKinds=Null)
		$consultationKindColl:=This._loadAsCollection()
		Use (cs.CacheManager.me)
			cs.CacheManager.me.consultationKinds:=New shared collection
			cs.CacheManager.me.consultationKinds:=$consultationKindColl.copy(ck shared; cs.CacheManager.me)
		End use 
	End if 
	
	
Function trigger()
	If (Application type=4D Local mode)
		This.cacheClear()
	Else 
		EXECUTE ON CLIENT("@"; "sfw_cacheManager"; "clear"; "ConsultationKind")
	End if 
	
	
Function _loadAsCollection()->$consultationKindColl : Collection
	
	$consultationKindColl:=This.all().toCollection("UUID, name").orderBy("name")
	