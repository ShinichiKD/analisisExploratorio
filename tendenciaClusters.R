# C�digos ejemplo utilizado en clase, dirigido a estudiantes del curso:
# Miner�a de Datos.-

# Con este c�digo se pretender responder la siguiente pregunta:
# �El DataSet posee tendencia a formar clusters?

# VER: http://www.sthda.com/english/articles/25-cluster-analysis-in-r-practical-guide/108-clustering-example-4-steps-you-should-know/

# Instalando librerias 'cluster' y  'factoextra'
install.packages(c("cluster", "factoextra"))

# Para asegurar que usted posee la �ltima versi�n de la librer�a,
# puede utilizar el siguiente enlace:
# EJECUTAR: devtools::install_github("kassambara/factoextra")
# para ello necesitar� instalar la librer�a 'devtools'
# EJECUTAR: install.packages("devtools")

# Cargamos el data set 'USArrests' disponible en R,
# Es recomendable revisar y entender el contexto de la base de datos.
# Para ello puede utilizar el comando:
# EJECUTAR: ?USArrests

data(USArrests)
View(USArrests)

# Los datos son escalados, cuando las variables son num�ricas, escalar los datos
# nos permitir� evitar sesgos en el c�lculos de los algoritmos.
# VER: https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/scale
# scale(), con la configuraci�n predeterminada,
# calcular� la media y la desviaci�n est�ndar de todo el vector, 
# luego "escalar�" cada elemento con esos valores restando la media 
# y dividiendo por la sd. (Si usa la escala (x, escala = FALSO), solo restar� 
# la media pero no se dividir� por la desviaci�n est�ndar).
df <- scale(USArrests)

# Llamada a la funci�n 'factoextra' instalada previamente
library("factoextra")

# VER https://www.datanovia.com/en/lessons/assessing-clustering-tendency/#statistical-methods

# Para determinar si el data set posee tendencia a ser clusterizado,
# se calcular� el indice llamado 'Hopskin statistic'.

# La aplicaci�n de la funci�n get_clust_tendency() de la libreria 
# 'factoextra' tiene como resultado una lista que contiene dos elementos:

# 1) Hopkins_stat ($hopkins_stat): Estad�stico de Hopkins. 
# RESULTADOS: Si el resultado es menor a 0.5, es posible concluir que el
# dataset es clusterizable. Valores cercanos a 0.0 muestran una alta capacidad
# para formar grupos o clusters.

# OJO!: Es importante tener en cuenta que la versi�n instalada de 'factoextra'
# sea la �ltima. En versiones anteriores el resultado es ( 1 - Hopkins_stat).

# Si usted desea conocer sobre los par�metros de la funci�n
# VER: https://www.rdocumentation.org/packages/factoextra/versions/1.0.5/topics/get_clust_tendency

res <- get_clust_tendency(df, 40, graph = TRUE)
res$hopkins_stat

# 2) M�todos visual (res$plot): Evaluaci�n visual de la tendencia de agrupamiento (VAT):
# pemite identificar zonas con tendencia a la formaci�n de grupos utilizando el algoritmo
# propuesto por Bezdek y Hathaway en el a�o 2002. Donde se grafica la matriz

# Dicho algoritmo calcula la matriz de disimilitud (DM) entre los objetos en el conjunto 
# de datos utilizando la medida de distancia euclidiana , en segundo lugar,
# reordena la matriz para que objetos similares est�n cerca uno del otro. 
# Este proceso crea una matriz de disimilitud ordenada (ODM). Finalmente,
# El ODM se muestra como una imagen de disimilitud ordenada (ODI), 
# que es la salida visual del IVA.

print(res$plot)


#RESULTADOS: Aqu� El nivel de color es proporcional al valor de la disimilitud 
# entre las observaciones: rojo puro si dist (xi, xj) = 0 y azul puro si dist (xi, xj) = 1. 
# Los objetos que pertenecen al mismo grupo se muestran en orden consecutivo.


# Si usted tiene alguna pregunta, no dude en contactarme:
# jgutierrezb@utalca.cl


# REFERNCIAS: 

#1) Han, Jiawei, Micheline Kamber, and Jian Pei. 2012. 
#   Data Mining: Concepts and Techniques. 3rd ed. Boston: 
#   Morgan Kaufmann. https://doi.org/10.1016/B978-0-12-381479-1.00016-2.

# 2) Lawson, Richard G., and Peter C. Jurs. 1990. 
# "New Index for Clustering Tendency and Its Application to Chemical Problems." 
# Journal of Chemical Information and Computer Sciences 30 (1): 36-41.
# http://pubs.acs.org/doi/abs/10.1021/ci00065a010.

