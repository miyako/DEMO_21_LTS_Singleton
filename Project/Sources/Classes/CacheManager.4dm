property consultationKinds : Collection
property titles : Collection

shared singleton Class constructor
/*
キャッシュ#1 - titles
共有シングルトンのコンストラクターは1度しか呼ばれない
This.titlesは全プロセス共通のメモリにキャッシュされる
敬称は事実上の定数なのでハードコーディングで十分
*/
	This.titles:=New shared collection(""; "Mr"; "Mrs"; "Ms")
	
Function titles_getPupMenu($code : Integer)->$chosenCode : Integer
/*
キャッシュ#1 - titles
ポップアップメニューを表示するユーテリティ関数
ローカルのコレクションを使用するのでサーバーに負荷がかからない（🌟最適化）
*/
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
	
Function _consultationKinds_load()
/*
キャッシュ#2 - consultationKinds
診療科目のリストはコンストラクターで1度限りではなく適宜dsからロードする
This.consultationKindsは全プロセス共通のメモリにキャッシュされる点は同じ
consultationKindsがNullでない限り再クエリはしない（🌟最適化）
*/
	If (This.consultationKinds=Null)
		ds.ConsultationKind.cacheLoad()
	End if 
	
Function consultationKind_get($uuid : Text)->$ck : Object
/*
ローカルのコレクションをクエリするのでサーバーに負荷がかからない（🌟最適化）
*/
	This._consultationKinds_load()
	$ck:=This.consultationKinds.query("UUID = :1"; $uuid).first()
	
Function consultationKind_getPupMenu($uuid_CK : Text)->$chosenUUID : Text
/*
キャッシュ#2 - consultationKinds
ポップアップメニューを表示するユーテリティ関数
ローカルのコレクションを使用するのでサーバーに負荷がかからない（🌟最適化）
*/
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
	