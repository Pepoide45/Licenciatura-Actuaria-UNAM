#
#   PROGRAMA DE SIMULACION Y AJUSTE DE MODELO DE SERIES DE TIEMPO MA1
#
#   Profrs. Francisco Sánchez Villarreal  Susana Barrera Ocampo


library(astsa)

library(tseries)


#	SE SIMULA SERIE MA(1)

SIM_MA1=arima.sim(list(order=c(0,0,1), ma=0.7), n=160,sd=0.2)

#  IMPRIME  LA SERIE SIMULADA 

SIM_MA1

#  GRAFICA LA SERIE SIMULADA

plot(SIM_MA1,type="l",main="Modelo MA(1) Simulado  Theta =0.7  S =0.2 ")

#  FUNCIONES DE AUTOCORRELACIÓN SIMPLES Y PARCIALES 

SIMPLES<-acf(SIM_MA1,lag.max=30)

SIMPLES

PARCIALES<-pacf(SIM_MA1,lag.max=30)

PARCIALES

#	FORMA ALTERNATIVA QUE GRAFICA ACF Y PACF JUNTAS

acf2(SIM_MA1)



#    MEDIA Y DESVIACION ESTANDAR DE LA SERIE

mean(SIM_MA1)
sd(SIM_MA1)

################################################################

#    GRABA OPCIONALMENTE EN ARCHIVO CSV LA SERIE SIMULADA 

#    write.csv(SIM_MA1,file="C:/CURSO ECONOMETRIA 2011/CURSO 2016/SERIES DE TIEMPO/EJEMPLOS Y EJERCICIOS/MA1 SIMULADO.csv")


# AJUSTA MODELO MA1

MODELO1<-arima(SIM_MA1,order=c(0,0,1))

#  IMPRIME LOS PARAMETROS DEL MODELO

MODELO1

str(MODELO1)

names(MODELO1)

#	OBTIENE LOS VALORES ESTIMADOS POR EL MODELO

#	Zt-ZtEst=et ->  ZtEst=Zt-et


AJUSTADOS<-SIM_MA1-MODELO1$residuals

AJUSTADOS

#	VARIANZA Y ERROR ESTANDAR ESTIMADOS PARA MODELO

MODELO1$sigma2

sqrt(MODELO1$sigma2)




plot(AJUSTADOS,type="l",col="1")

#	GRAFICA AMBOS OBSERVADOS Y ESTIMADOS JUNTOS

par(new=TRUE)

plot(SIM_MA1,type="l",col="2")

#	SE REVISAN RESIDUALES

RESIDUAL<-residuals(MODELO1)

RESIDUAL

plot(RESIDUAL,,type="l")

#     AUTOCORRELACIONES SIMPLES Y PARCIALES DE RESIDUALES PARA VERIFICAR QUE NO HAY
#     PATRONES SUBYACENTES

SIMPLES<-acf(RESIDUAL,lag.max=30)

SIMPLES

PARCIALES<-pacf(RESIDUAL,lag.max=30)

PARCIALES

#	PRONOSTICOS HACIA ADELANTE DEL MODELO POR 12 PERIODOS

sarima(SIM_MA1,0,0,1,0,0,0,0)

sarima.for(SIM_MA1,12,0,0,1,0,0,0,0)






#	PROBLEMAS CON BIBLIOTECAS

#	AJUSTADOS<-fitted.values(MODELO1)











