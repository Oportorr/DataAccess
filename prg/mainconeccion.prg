CLOSE DATA ALL
set procedure TO c:\vsirhv7SQL\libs\prhlib00
=GSet_up()
DO ENTORNO IN c:\vsirhv7SQL\LIBS\PRHLIB00.PRG

IF FILE('c:\Vsirhv7Sql\Project\datasql.DBC')
OPEN DATABASE c:\Vsirhv7Sql\Project\datasql.DBC SHARED
else
OPEN DATABASE datasql.DBC SHARED
endif

PUBLIC conexion,usuario,clave
conexion=DBGETPROP("Eikon_r4_sql","CONNECTION","DATASOURCE")
usuario=DBGETPROP("Eikon_r4_sql","CONNECTION","USERID")
clave=DBGETPROP("Eikon_r4_sql","CONNECTION","PASSWORD")

set reproce to 4 second
SET SYSMENU OFF
SET ESCAPE OFF
_screen.caption='Eikôn - Manejo de Conexión '
_screen.closable = .f.
_screen.windowstate=2
_Screen.Icon='C:\VSIRHV7SQL\BMPS\EIKONICONO.ICO'
*!*	_screen.icon='c:\program files\devstudio\vb\graphics\icons\office\folder04.ico'
set classlib to c:\vsirhv7SQL\libs\Crhge000

do form login2
*!*	do form frhut

SET ESCAPE ON
clos database   
