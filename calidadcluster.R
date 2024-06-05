# Codigo dirigido a estudiantes del curso:
# Miner�a de Datos. Universidad de Talca.-

# Con este c�digo se pretender responder la siguiente pregunta:
# �Cu�l es la calidad de los clusters formados?

# Existen algunas librer�as en R que pueden facilitar el trabajo.
# En este caso, utilizaremos los paquetes  "cluster" y "fpc" . 

# En primer lugar debemos recordar que el objetivo es lograr que:

# 1) Los objetos en el mismo cluster sean lo m�s similares posible.
# 2) Los objetos en diferentes clusters sean altamente distintos.

# Existen 3 tipos de medidas que pueden ser abordadas:

# 1) Intra-cluster: Calculo de calidad teniendo en cuenta solo la informaci�n de los 
#    grupos creados.
# 2) Extra-cluster: Determinaci�n de la calidad de los grupos explotando informaci�n 
#    extra, tal como valores de clases conocidas.
# 3) Relativas: Evaluaci�n de la estructura de los clusters variando par�metros.

# VER: https://www.datanovia.com/en/lessons/cluster-validation-statistics-must-know-methods/

# Cuando se trabaja con algoritmos de aprendizaje no supervisado, es probable que las  
# clases o grupos a�n no han sido identificadas, es decir, no contamos con algunos 
# resultados esperados que nos permitan comparar o calibrar nuestros algoritmos.
# Por lo tanto en este caso emplearemos medidas Intra-cluster ya que no contamos
# con informaci�n extra. Dentro de este contexto describir� dos de las m�s conocidas;
# "silhouette" y "Dunn".

# Instalamos las librer�as correspondientes
install.packages(c("cluster", "fpc"))

# Podr�an requerir esta librer�a: 
# EJECUTAR: install.packages("digest")

# Invocamos las librer�as previamente instaladas
library(cluster)
library(fpc)

# Utilizaremos el dataset Iris.
# VER:?iris
# Eliminamos la columna 5, correspondiente a la clase
df <- iris[, -5]

# Escalamos los datos
# VER: archivo R "Tendencia para formar cluster", donde se explica scale()
df <- scale(df)

# Para efectos de este ejemplo, se utilizar� kmeans para realizar encontrar los clusters
# VER: ?kmeans

# Se aplica kmeans con k = 4 ( 4 clusters) 
k <- kmeans(df, 4, nstart=250, iter.max=1000)  

# Inspecci�n visual de los resultados obtenidos. Se debe tener en cuenta que solo 
# se grafican las dos primeras dimensiones del dataset "Sepal.Width" y "Sepal.Length".
plot(df, col=k$clust)

# A partir de este punto se realizar�n los calculos necesarios para estimar
# el �ndice de silhouette.

# La funcion silhouette() de la librer�a "cluster" ser� la encargada de calcular el �ndice.
# Sin embargo, uno de sus par�metros corresponde al cuadrado de la matriz de disimilitud. 
# Para realizar este c�lculo utilizaremos la funci�n daisy().

# Calculamos la matriz de disimilitud de los datos.
dissE <- daisy(df) 

# Elevamos los resultados al cuadrado
dE2   <- dissE^2

# Procesamos la informaci�n y obtenemos el �ndice buscado
sk2   <- silhouette(k$cl, dE2)

#RESULTADOS: la funci�n silhouette() permite generar un gr�fico de los resultados.
plot(sk2, col = c("red", "green", "blue","black"))

# Este gr�fico muestra el �ndice de silueta para cada instancia. Es importante
# destacar que este indicador se encuentra en el rango [-1,1]. Donde un resultado
# cercano a 1 indica que los clusters formados son compactos internamente y separados 
# entre clusters.

# Se considera que un buen promedio general (Average Silhouette width) cuando supera
# el valor de 0.5 . No obstante, es necesario verificar los promedios para cada cluster.
summary(sk2)

# En segundo lugar, calcularemos el indice "Dunn"

km_stats <- cluster.stats(dist(df),  k$cluster)
# Dun index

km_stats$dunn

# RESULTADOS: Dunn tiene un rango [0,1]. Donde valores cercanos a 1 muestran una buena calidad en 
# la conformaci�n de los clusters


# Finalmente es necesario probar un n�mero razonable de combinaciones de cada algoritmo aplicado.
# De esta forma, usted podr� comparar los resultados obtenidos en cada uno de los casos y utilizar
# estos �ndices como herramientas de apoyo.

# OJO! Recuerden que esta no es la �nica forma para realizar este tipo de an�lisis. Existen otras
# librerias y softwares evolucionando cada d�a. Esto es solo una referencia para que usted
# pueda comenzar en el mundo de la Miner�a de Datos.

# Si usted tiene alguna pregunta, no dude en contactarme:
# jgutierrezb@utalca.cl

# REFERENCIAS:

# 1) Brock, Guy, Vasyl Pihur, Susmita Datta, and Somnath Datta. 2008.
# "ClValid: An R Package for Cluster Validation." Journal of Statistical 
# Software 25 (4): 1-22. https://www.jstatsoft.org/v025/i04.
