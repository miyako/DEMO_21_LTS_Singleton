Class extends Entity

local Function get nameInWindowTitle()->$nameInWindowTitle : Text
	
	$nameInWindowTitle:=This.firstName
	
	
Function getFullName()->$fullName : Text
	var $coll : Collection
	
	$coll:=New collection(This.title; This.firstName; This.lastName)
	$fullName:=$coll.join(" "; ck ignore null or empty)
	
Function get age()->$age : Integer
	
	$age:=Int((Current date()-This.birthdate)/365)
	
Function get ageS()->$ageS : Text
	
	$ageS:=String(Int(Current date()-This.birthdate/365))+" Years old"
	
Function get year()->$year : Integer
	
	$year:=Year of(This.birthdate)
	
local Function get title()->$title : Text
	$title:=cs.CacheManager.me.titles[This.titleCode]
	