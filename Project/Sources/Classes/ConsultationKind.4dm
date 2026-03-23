Class extends DataClass

local Function cacheClear()
/*
localに注目
この関数はクライアント側で実行される
Nullにしておけば次回のアクセスでconsultationKindsがキャッシュされる（🌟最適化）
*/
	If (cs.CacheManager.me.consultationKinds#Null)
		Use (cs.CacheManager.me)
			cs.CacheManager.me.consultationKinds:=Null
		End use 
	End if 
	
Function trigger()
/*
診療科目のリストをローカルのキャッシュからクリアするよう
クライアントに命令するメソッド（この例題ではsfw_cacheManagerが省略されている）
*/
	If (Application type=4D Local mode)
		This.cacheClear()
	Else 
		EXECUTE ON CLIENT("@"; "sfw_cacheManager"; "clear"; "ConsultationKind")
	End if 
	
local Function cacheLoad()
/*
localに注目
この関数はクライアント側で実行される
診療科目のリストは頻繁に参照する必要があるが滅多に変わるものではない
毎回データベースをクエリする代わりに共有シングルトンにコピーを作成しておく（🌟最適化）
*/
	var $consultationKindColl : Collection
	If (cs.CacheManager.me.consultationKinds=Null)
		$consultationKindColl:=This._loadAsCollection()
		Use (cs.CacheManager.me)
			cs.CacheManager.me.consultationKinds:=New shared collection
			cs.CacheManager.me.consultationKinds:=$consultationKindColl.copy(ck shared; cs.CacheManager.me)
		End use 
	End if 
	
Function _loadAsCollection()->$consultationKindColl : Collection
/*
localではない点に注目
all(),toCollection(),orderBy()はサーバー側で実行される（🌟最適化）
*/
	$consultationKindColl:=This.all().toCollection("UUID, name").orderBy("name")