library(caret)
library(ggplot2)
library(tidyverse)

set.seed(2018)


#particion de la base de datos en
#entrenamiento y validacion.
index<-createDataPartition(churn$Churn,p=0.7,list=F,times = 1) #

train<-datos[index,] #datos de entrenamiento del modelo
test<-datos[-index,] #datos para probar el modelo, datos que el modelo no conoce.

#creacion delo modelo logistico donde Y es nuestra variable respuesta
#en este caso es binaria, 1 ó 0
modelo_logistico<-glm(Y~.,data=train,family = binomial(link="logit")) 

#Evaluar cual de los modelos es mejor-----------------

logitpredict1<-predict(modelo_logistico,test,type="response")

test$YpredichoLg<-predict(modelo_logistico,test,type="response")

confusionMatrix(prediccionlogit(0.5),test$Y) #Funcion de la libreria Caret esima la matriz de confusion con corte en 50%