Parameters pForm
Clear Events
On Shutdown
On Error
On Shutdown Do CloseApplication()
Public gcOldPath As String
gcOldPath=Set("Path")
lcPath=Setpath()
************************************************
lcDrive=Sys(5)
lsCurDir=Curdir()
DefaultPath=Addbs(lcDrive+lsCurDir)
Set Default To &DefaultPath
************************************************
Set Path To Curdir() Additive
_Screen.AddProperty('gIsValid',.F.)

Set Escape Off
Set Notify Off
Set Exact On



*Set Step On
Local lnByte As Inter
lnByte =0

Note: This Is the Default Password
lcDefaultPass=AenCode("EikonIn2015")

nFileCount =Adir(aArray,"DataAccess.dat")

If nFileCount <= 0 Then &&El Archivo no Existe, pondremos Password por defecto "EikonIn2015"
	lnByte=Strtofile(lcDefaultPass,"DataAccess.dat",.T.)
	If lnByte <=0 Then
		=Messagebox("Error Creando el Archivo de Verificacion.",0+16,"Error Accesando Archivo.")
	Endif
Endif

*Set Step On


If Vartype(pForm)= "C"

	If Upper(pForm)=Upper("CONN")
		Do Form dataconexion01.scx
		Clear Events
		On Shutdown
		On Error
	Endif
Else
	Do Form Dataacces.SCX
Endif


Function CloseApplication


	For Each oFrm In _Screen.Forms
		oFrm.Release()
	Next
	Close Tables All
	On Shutdown
	Clear Events
	On Error
Endfunc

*!*	****************************************************************************
*!*	* AenCode
*!*	*
*!*	* Descripcion:
*!*	*
*!*	* Encripta y  una cadena de Texto

*!*	* Historia de Modificaciones:
*!*	* Agostor 16, 2004 : Creado [Oscar Portorreal]
*!*	****************************************************************************

*====================================
Function AenCode(tcKeyWord)

	*lcRaw=Upper(Alltrim(tcKeyWord))
	lcRaw=Alltrim(tcKeyWord)
	lnVar=Int(Rand()*10)
	lcEnc=Alltrim(Str(lnVar))

	For lncnt=1 To Len(lcRaw)
		lcChar=Substr(lcRaw,lncnt,1)
		lcEnc=lcEnc + Chr(Asc(lcChar)+ 7 + lnVar + lncnt +1)
	Next
	Return lcEnc

Endfunc


*!*	****************************************************************************
*!*	* Adecode
*!*	* Descodifica una cadena codificada con Aencode
*!*	*
*!*	* Historia de Modificaciones:
*!*	* Septiembre 11, 2007 : Creado [Oscar Portorreal]
*!*	****************************************************************************
*_cliptext=Adecode("2Pux}}YDCEJ}")
Function Adecode(tcKeyWord)
	*Set Step On
	lcEnc=Alltrim(tcKeyWord)
	lnVar=Val(Left(lcEnc,1))
	lcRaw=''

	For lncnt = 2 To Len(lcEnc)
		lcChar=Substr(lcEnc,lncnt,1)
		lcRaw=lcRaw + Chr(Asc(lcChar)- (7 + lnVar + lncnt))
	Next

	Return lcRaw

Endfunc



*!*	****************************************************************************
*!*	* GetCredentias
*!*	* Lee la informacion del archivo de acceso
*!*	*
*!*	* Historia de Modificaciones:
*!*	* 15 Abril , 2015 : Creado [Oscar Portorreal]
*!*	****************************************************************************
Function GetCredentias()
	lcReadedFile=Adecode(Filetostr("DataAccess.dat"))
	Return lcReadedFile
Endfunc



*!*	****************************************************************************
*!*	* SaveCredentias
*!*	* Guarda la informacion del archivo de acceso
*!*	*
*!*	* Historia de Modificaciones:
*!*	* 14 Abril , 2016 : Creado [Oscar Portorreal]
*!*	****************************************************************************
Function SaveCredentias(pcPass)
	Local lnByte,lcReturn As Integer

	lnByte   = 0
	lcReturn = 0

	lcPass=AenCode(pcPass)

	nFileCount =Adir(aArray,"DataAccess.dat")

	If nFileCount <= 0 Then &&El Archivo no Existe, pondremos Password por defecto "EikonIn2015"
		=Messagebox("Error Accesando al Archivo de Verificacion.",0+16,"Eikondataacces - Fallo de Seguridad")
	Else
		lnByte=Strtofile(lcPass,"DataAccess.dat",.F.)
		If lnByte <=0 Then
			=Messagebox("Error Creando el Archivo de Verificacion.",0+16,"Error Accesando Archivo.")
		Endif
	Endif

	Return lnByte
Endfunc



Function GetDataSource()
	**Try
	Declare Integer SQLDataSources In ODBC32.Dll ;
	INTEGER nODBCHandle, ;
	SHORT nDirection, ;
	STRING @szDSN, ;
	INTEGER nDSNMax, ;
	INTEGER @pcbDSN, ;
	STRING @szDescription, ;
	INTEGER nDBTypeMax, ;
	INTEGER @pcbDescriptionn

	nFirstDSN = 2
	nNextDSN = 1
	szDSN = Space(128)
	nDSNMax = 128
	pcbDSN = 0
	szDescription = Space(128)
	nDBTypeMax = 128
	pcbDescriptionn = 0
	Create Cursor DSNList (dsn c(40),Driver c(40))
	nODBCHandle = Int(Val(Sys(3053)))
	nDirection = nFirstDSN && 2
	iRetVal = 0
	Do While iRetVal = 0 && no errors

		iRetVal = SQLDataSources(nODBCHandle, ;
		nDirection, ;
		@szDSN, ;
		nDSNMax, ;
		@pcbDSN, ;
		@szDescription, ;
		nDBTypeMax, ;
		@pcbDescriptionn)

		m.dsn = Left(szDSN,pcbDSN)
		m.driver = Left(szDescription,pcbDescriptionn)
		If iRetVal = 0
			Insert Into DSNList From Memvar
		Endif
		nDirection = nNextDSN && 1
	Enddo
	Clear Dlls 'SQLDataSources' && release DLL function from memory
	Clear Dlls All
	*SET STEP ON
	Select DSNList
	*Catch To oError
	*SET STEP ON
	*	Messagebox(oError.Message +" En la Linea " + Alltrim(Str(oError.ErrorNo)) + Alltrim	(Str(oError.Lineno)) +" Procedimiento "+ oError.Procedure,16,"Error en el Programa")


	*!*	Finally

	*!*	Endtry



	*** <summary>
	*** Para que tome el default y la ruta de forma dinamica
	*** </summary>
	*** <remarks></remarks>
Procedure Setpath()
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