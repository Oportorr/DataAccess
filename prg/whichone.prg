Local lcCurdir, lcHomedir, lcOldonerror, lcLastcompile, llError
lcCurdir = Sys(5)+Curdir()
If Type('_vfp.ActiveProject.Name')<>'C'
	Modify Project ? Nowait
	If Type('_vfp.ActiveProject.Name')<>'C'
		Messagebox("You must have a project open!", 48, "No project open")
		Return
	Endif
Endif
lcOldonerror = On('Error')
Create Cursor CompProbs (prOgramname C (50), erRmessage C (100))
Use Noupdate (_vfp.ActiveProject.Name) Again Alias thEproject In 0
Select thEproject
lcHomedir = Addbs(Alltrim(thEproject.HomeDir))
Cd (lcHomedir)
Select Padr(Alltrim(Name), 128) As cnAme, Type As ctYpe From thEproject  ;
	WHERE Inlist(Type, "d", "K", "R", "B", "V") Into Cursor filelist
Select filelist
Use In thEproject
Scan
	lcLastcompile = cnAme
	llError = .F.
	On Error llError = .T.
	Wait Window Nowait "Compiling "+cnAme
	Do Case
	Case ctYpe="d"
		Compile Database (cnAme)
	Case ctYpe="K"
		Compile Form (cnAme)
	Case ctYpe="R" .Or. ctYpe="B"
		Compile Report (cnAme)
	Case ctYpe="V"
		Clear Classlib (cnAme)
		Compile Classlib (cnAme)
	Otherwise
	Endcase
	Wait Clear
	On Error &lcOldonerror
	If llError
		Insert Into CompProbs Values (lcLastcompile, Message())
	Endif
Endscan
Select CompProbs
If Reccount()>0
	Activate Screen
	Browse Noinit
Else
	Messagebox("No problems found during compile", 64, "Success!")
Endif
Use In CompProbs
Use In filelist
Cd (lcCurdir)
Endproc
*
