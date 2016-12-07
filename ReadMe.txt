La siguiente utileria es realizada con la idea de restringir un poco el acceso a nuestro contenedor de base de datos, habilitando para ellos los eventos o procedimientos de la misma
incluye tambien un formulario que se ejecutara cuando tratemos de acceder o modificar la conexion ODBC de nuestra base de datos, con el comando: [ MODIFY CONNECTION ] actualmente cualquiera puede ver la clave si ejecuta [ MODIFY CONNECTION ] desde la ventana de comando de Visual FoxPro, con esta herramienta estaremos ocultando dicha clave.



Pasos para la aplicacion: 
1-Hacer una copia de la base de datos(.dbc,.dct, dcx) - > Por si acaso :)
1-Poner la aplicacion  "eikondataacces.app" en el folder que contiene  la base de datos(.DBC), conjuntamente con el icono
2-Abrir la base  de datos con el comando [open database TuBaseDeDatos.dbc]
3-Ejecuta el comando [ MODIFY PROCEDURE ], en la venta de comando que aparece, pegar el codigo que esta en el archivo "sp_dbc.prg" guardar y cerrar
4-Ejecutar el comando [ DBSetProp("datasql",'Database','DBCEvents',.t.) ] para habilitar los eventos en la base de datos
5-Cerrar la base de datos


Desde  este momento la base datos va a pedir una contraseña cuando se habierta, o se quiera deshabilitar o habilitar los eventos de la base de datos, la contraseña por defecto es:
"EikonIn2015"   es case sensetive, puede ser cambiada dando click en el boton con imagen de llave.

Hay muchos otros eventos que se pueden habilitar,tales como:
*BeforeOpenTable() &&Antes de abri la tabla
*BeforeDropTable() &&Antes de hacer drop a la tabla

Tiene varias opciones para tratar de limitar el acceso a nuestro contenedor de base de datos, lo puedes ver  ejecutando el comando [modify database] y luego haciendo click en propiedades
es cierto que las tablas ,se pueden abrir facilmente incluso con Excel, pero de esta manera se lo ponemos un poco mas complicada y aun mas si en lugar .dbf utilizas vistas remotas.


Adicionalmente esta aplicacion hace un "Wrap"que permiter ocultar la clave y usuario de la base de datos
muy util si es una base de datos tipo MSSQL, MySQL, Oralce u otra.

si ejecutas el comando [ MODIFY CONNECTION ] en lugar de salir la pantalla habitual veras una pantalla customizada
desde donde podras cambiar la conexion a la base de datos y/o asignar los diferentes ODBC que tengas en el equipo.


[Disclaimer]
Nota: No me hago responsable de ningun daño realizado por esta herramienta.

Cualquier error o mejora, pueden reportarla a: oscarportorreal@gmail.com