#     PROGRAMA PARA SUPERVIVENCIA
#     EJEMPLO 2 DE NOTAS SOBRE KAPLAN MEIER SIN CENSURA
#     INSTALAR Y CARGAR PAQUETES survival) KMsurv ggplot2 ggfortify  
#
#     Profr. Francisco S�nchez Villarreal
# ..................................................................................................................................


library(KMsurv)

library(survival)


#  SE LEE TABLA DE DATOS 

#  Sustituir la ruta de acceso a los datos de acuerdo a su propia carpeta

EJEMPLO1<-read.csv(file="C:/RESP  ORIG/R LENGUAJE ESTADISTICO/EJERCICIOS DE PRUEBA/SUPERVIVENCIA KAPLAN MEIER EJEMPLO 1 NOTAS.csv",header=TRUE,dec=".",fill=TRUE)

attach(EJEMPLO1)

EJEMPLO1

MISURV<-Surv(EJEMPLO1$TIEMPO,EJEMPLO1$STATUS)

MISURV

#    SE ESTIMA LA FUNCI�N DE SUPERVIVENCIA KAPLAN MEIER ERROR EST�NDAR CON F�RMULA DE GREENWOOD


KAPLAN<-survfit(Surv(EJEMPLO1$TIEMPO,EJEMPLO1$STATUS)~0)


KAPLAN

summary(KAPLAN)

#	GR�FICA DE LA FUNCI�N DE SUPERVIVENCIA

plot(KAPLAN,xlab="Tiempo",conf.int=T,ylab="Probabilidad de Supervivencia",main="Kaplan Meier Ejemplo 2 Notas")

names(KAPLAN)


SUPER<-plot(KAPLAN$surv)


#	CALCULAMOS LA FUNCI�N DE DISTRIBUCI�N ACUMULATIVA F(x)

FX<-1-KAPLAN$surv

FX

par(new=TRUE)

plot(FX)

