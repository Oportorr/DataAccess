Procedure dbc_OpenData(cDatabaseName, lExclusive, lNoupdate, lValidate)
	*Immediately after DBC is opened.
	*set step on
	*** Check for Run Mode
	Release glExeRunning,gcOldPath
	Public glExeRunning,gcOldPath
	Local lReturn As Boolean
	gcOldPath=Set("Path")
	Local lReturn As Boolean
	setpath()

	glExeRunning=Application.StartMode()


	If (glExeRunning)=0&& <> 1 Or(glExeRunning <>4)

		Do dataaccess.App
		Set Path To
		Set Path To &gcOldPath

		If _Screen.gIsValid Then
			lReturn = .T.
		Else
			=Messagebox("Clave es Invalida. Accion Denegada",0+16,"Clave Invalida.")
			lReturn = .F.
		Endif

		Return lReturn

	Endif
Endproc

Procedure dbc_BeforeModifyProc()
	*Just before a DBC stored procedure is modified.
	Release glExeRunning,gcOldPath
	Public glExeRunning,gcOldPath
	Local lReturn As Boolean
	gcOldPath=Set("Path")
	glExeRunning=Application.StartMode()
	setpath()
	If (glExeRunning)=0&&

		Do dataaccess.App
		Set Path To &gcOldPath

		*Set Step On

		If _Screen.gIsValid Then
			lReturn = .T.
		Else
			=Messagebox("Clave es invalida. Accion denegada",0+16,"Clave Invalida.")
			lReturn = .F.
		Endif

		Return lReturn
	Endif
Endproc

*** <summary>
*** Para que tome el default y la ruta de forma dinamica
*** </summary>
*** <remarks></remarks>
Procedure dbc_BeforeDBSetProp(cName, cType, cProperty, ePropertyValue)
	*Just before DBSetProp() executes. Return .F. to prevent property value from being set.

	*Just before a DBC stored procedure is modified.
	*SET STEP ON
	Release glExeRunning,gcOldPath
	Public glExeRunning,gcOldPath
	Local lReturn As Boolean
	gcOldPath=Set("Path")
	setpath()
	glExeRunning=Application.StartMode()
	If (glExeRunning)=0&&
		If Upper(cType)=Upper("Database")

			Do dataaccess.App

			If _Screen.gIsValid Then
				lReturn = .T.
			Else
				=Messagebox("Clave es Invalida. Accion Denegada",0+16,"Clave Invalida.")
				lReturn = .F.
			Endif

		Endif
		Return lReturn

	Endif

Endproc

*** <summary>
*** Para que tome el default y la ruta de forma dinamica
*** </summary>
*** <remarks></remarks>
Procedure setpath()

	Local lcSys16, lcProgram, lcPath, lcOldDir,lsCurDir As String


	lcSys16 = Sys(16, 1)
	lcProgram = Upper(Substr(lcSys16, At(":", lcSys16) - 1))

	*Set Path To
	lcDefaultDrive=Sys(5)
	lcDefault=Set("Default")

	*!*	Cd Left(lcProgram, Rat("\", lcProgram))
	*!*	Cd ..


	lcDefaultDrive=Sys(5)
	lcDefault=Set("Default")




	lcCurDrive=Sys(5)
	If (".EXE"$lcProgram) Or (".APP"$lcProgram)
		lsCurDir=Curdir()
		lcPath = Addbs(Fullpath(lsCurDir))
	Else
		Cd Left(lcProgram, Rat("\", lcProgram))

		If "PROGRAMS"$lcProgram Or ".PRG"$lcProgram
			Cd ..
		Endif
		lsCurDir=Sys(5)+Curdir()
		lcPath = Home() + ";" + Addbs(Fullpath(lsCurDir))
	Endif

	pcDir =lsCurDir
	If  pcDir=="\" Then
		*		Set Default To &lcCurDrive&lsCurDir
		Set Default To &lsCurDir

		Set Path To "&lcPath" Additive
		Return
	Endif
	*	Set Default To &lcCurDrive&lsCurDir
	Set Default To &lsCurDir

	N = Adir( laFiles, pcDir + "\*.*", "D" ) && find the files and subdirectories
	=Asort( laFiles )


	For i = 1 To N
		If ( Inlist( laFiles[i,1], ".", ".." ) )
			* ignore these two special directory entries
			Loop
		Endif
		If ( "D" $ laFiles[i,5] )
			*		SET STEP ON
			lsFolder=laFiles[i,1]
			lcPath =lcPath+";"+(lsFolder)
			*		Set Path To &lcPath  Additive
		Endif

	Endfor
	Set Path To "&lcPath"  Additive
	Return lcPath
Endproc

*!*	******************************************

*!*	******************************************
Procedure dbc_BeforeModifyConnection(cConnectionName)
*Just before a connection is modified. Return .F. to prevent modification.
**Set Step On
	Release glExeRunning
	Public glExeRunning
	*set step on
	Local lReturn As Boolean
	setpath()
	glExeRunning=Application.StartMode()
	If (glExeRunning)=0&&

	*set step on
	*	Do dataaccess.App WITH "Conn"
		Do dataaccess.App With "Conn"
		Set Path To &gcOldPath


		Return .F.
	Endif
Endproc
