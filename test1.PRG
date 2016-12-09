Set Step On


Dimension aryFiles(1)
*=GetAllFiles(Getdir(), @aryFiles)
=GetAllFiles(Curdi(), @aryFiles)
Set Step On

Function GetAllFiles(cDirectory, aryParam)
	Local Array aryTemp(1,5)
	Local nCount, nMax, nLen, cFile

	Set Default To (cDirectory)

	=Adir(aryTemp, "*.*", "AHRSD", 1)
	nMax = Alen(aryTemp,1)
	For nCount = 1 To nMax
		cFile = Alltrim(aryTemp(nCount,1))
		If !(cFile == ".") And !(cFile == "..")
			If "D" $ aryTemp(nCount,5)
				=GetAllFiles(Addbs(cDirectory + cFile), @aryParam)
			Else
				nLen = Alen(aryParam)
				If !Empty(aryParam(nLen))
					Dimension aryParam(nLen + 1)
					nLen = nLen + 1
				Endif
				aryParam(nLen) = cDirectory + cFile
			Endif
			? cDirectory + cFile
		Endif
	Endfor
Endfunc




**===========================



loFSO=Createobject('Scripting.FileSystemObject')
lsDrive=Sys(5)
loFolders=loFSO.GetFolder(lsDrive+'\\\somefolder')
For Each loSomeFolder In loFolders.Subfolders
	If !File(lsDrive+'\\\somefolder\\\'+Allt(loSomeFolder.Name))
		Wait Window 'Checking '+ lsDrive+'\\\somefolder\\\'+Allt(loSomeFolder.Name) Nowait
		For Each loFile In loSomeFolder.Files
			* DO SOMEHTING WITH THE FILE
			* lsDrive+'\\\somefolder\\\'+ allt(loSomeFolder.Name)+'\\\'+allt(loFile.Name)
		Endfor
	Endif
Endfor
Release loFolders
Release loFile
Release loFSO
Wait Clear


End;

*!*	gnDbcnumber = Adir(gaDatabase, '*.*')  && Create array

*!*	Clear

*!*	For nCount = 1 To gnDbcnumber  && Loop for number of databases

*!*		? gaDatabase(nCount,1)  && Display database names

*!*	Endfor

*!*	Set Path To Home( )  && Set path to Visual FoxPro directory
