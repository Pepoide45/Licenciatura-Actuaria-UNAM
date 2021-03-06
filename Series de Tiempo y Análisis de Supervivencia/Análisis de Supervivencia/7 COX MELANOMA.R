#     PROGRAMA PARA REGRESI�N MULTIPLE
#     EJEMPLO DE REGRESION DE COX   
#
#     Profr. Francisco S�nchez Villarreal
# ..................................................................................................................................

#     INSTALAS Y CARGAR PAQUETES

library(KMsurv)

library(survival)

library(ggplot2)

library(ggfortify)


#  SE LEE TABLA DE DATOS EN CSV

#  Sustituir la ruta de acceso a los datos de acuerdo a su propia carpeta

MELANOMA<-read.csv(file="C:/RESP  ORIG/R LENGUAJE ESTADISTICO/EJERCICIOS DE PRUEBA/MELANOMA.csv",header=TRUE,dec=".",fill=TRUE)

attach(MELANOMA)

#  Se imprime el contenido de la tabla

MELANOMA

#  SE CREA EL OBJETO DE CLASE Surv CON TIEMPO Y STATUS DEL EVENTO

MISURV<-Surv(MELANOMA$TIEMPO,MELANOMA$STATUS)

MISURV

#	SE OBTIENEN LOS CALCULOS DE KAPLAN MEIER CONJUNTA Y POR SEXO

KAPLAN<-survfit(MISURV~1)

KAPLAN

summary(KAPLAN)


plot(KAPLAN,xlab="Tiempo",ylab="Probabilidad de Supervivencia",main="S(t) K.M. Censurados Melanoma")

KSEXO<-survfit(MISURV ~ SEXO,conf.type = "log-log")

KSEXO

summary(KSEXO)


plot(KSEXO,xlab="Tiempo",ylab="Probabilidad de Supervivencia",main="S(t) K.M. Melanoma por Sexo",
	col=c("blue","red"))

#	POR TRATAMIENTO

KTRATA<-survfit(MISURV ~ TRATA,conf.type = "log-log")

KTRATA

summary(KTRATA)


plot(KTRATA,xlab="Tiempo",ylab="Probabilidad de Supervivencia",main="S(t) K.M. Melanoma por Tratamiento",
	col=c("blue","red"))



#  SE AJUSTA EL MODELO DE COX CUYOS ARGUMENTOS SON LOS SIGUIENTES
# args(coxph)
# coxph(formula, data=, weights, subset, 
#      na.action, init, control, 
#      ties=c("efron","breslow","exact"), 
#      singular.ok=TRUE, robust=FALSE, 
#      model=FALSE, x=FALSE, y=TRUE, tt, method, ...)

# ties indica como se deben de anejar casos ligados, esto es con tiempos iguales de 
# supervivencia. El m�todo "efron" es usualmente preferido al m�s popular "breslow".
# El m�todo "Exact" reqquiere m�s recuros de c�mputo.

# robust = TRUE indica el c�lculo de coeficientes de varianza robustos. Por default es FALSE


COXREG<-coxph(MISURV~EDAD+SEXO+INICIO+TRATA,method="breslow")



#   SE IMPRIME EL CONTENIDO DEL OBJETO CON MODELO AJUSTADO

COXREG

#   PROPORCIONA UNA DESCRIPCI�N M�S AMPLIA DE COEFICIENTES Y MODELO

summary(COXREG)

#	GRAFICA FUNCI�N DE SUPERVIVENCIA AJUSTADA CON REGRESI�N DE COX


plot(survfit(COXREG), xlab="Weeks", ylab="Proportion Not Rearrested")


#	LA FUNCI�N surfit PERMITE OBTENER ESTIMACI�N DE LA FUNCI�N DE SUPERVIVENCIA

MODELO<-survfit(COXREG)

MODELO

summary(MODELO)

names(MODELO)

#	PROBABILIDADES DE SUPERVIVENCIA ESTIMADOS PARA LOS SUJETOS DE PRUEBA

SUP_FUN=MODELO$surv

SUP_FUN

#	TIEMPOS DE SUPERVIVENCIA OBSERVADOS EN LOS SUJETOS DE PRUEBA ORDENADOS DE MENR A MAYOR

TIEMPO=MODELO$time

TIEMPO


#	SE UNEN VARIABLES DE TIEMPO Y SUPERVIVENCIA EN PAREJAS

DATASALIDA<-paste(TIEMPO,SUP_FUN,sep=" ")

DATASALIDA

#	OTRA ALTERNATIVA

DATASAL<-cat(TIEMPO,SUP_FUN)

DATASAL


#   GRAFICA FUNCI�N DE SUPERVIVENCIA

plot(MODELO, conf.int=T,main="Funci�n de Supervivencia Estimada COX",xlab="Tiempo",ylab="Prob. Supervivencia")


#   GRAFICA FUNCI�N DE RIEZGO ACUMULADO

plot(MODELO,fun="cumhaz",conf.int=T,col=2,main="Funci�n de Riesgo Acumulado Estimada")


################################################################################



