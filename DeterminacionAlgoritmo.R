# Codigo dirigido a estudiantes del curso:
# Miner�a de Datos. Universidad de Talca.-

# Con este c�digo se pretender responder la siguiente pregunta:
# �Como selecciono el algoritmo de clustering indicado para mi dataset?

# Sabemos que existe un conjunto amplio de diferentes algoritmos de clustering,
# pero, seleccionar el m�s adecuado puede resultar ser una tarea dificil.
# Sin embargo, Existen algunas librer�as en R que pueden facilitar el trabajo.
# En este caso, utilizaremos los paquetes  "cluster" y "clValid". 
library(readr)
# Se utilizar� la base de datos "dataForTesting_1.csv" disponible para los estudiantes del ramo
data <- read_csv("/Users/pablo/Desktop/analisisExploratorio/dataForTesting_1.csv",col_names = FALSE)
View(data)

library(cluster)

# La librer�a clValid permitir� comparar tres �ndices: "Connectivity" , "Dunn" y "Silhouette". A partir de 
# esto usted podr� seleccionar el algoritmo que presenta un mejor desempe�o. Adicionalmente es posible determinar
# un n�mero �ptimo de clusters, sin embargo para este �ltimo objetivo se recomienda el uso de la librer�a "Nbclust"
# ya que incorpora alrededor de 30 �ndices diferentes. 

library("clValid")
data<- as.data.frame(data)
intern <- clValid(data, nClust = 2:6, clMethods = c("hierarchical","kmeans","pam"), 
                  validation = "internal", maxitems = 6000)

# Summary
summary(intern)

# Los resultados para este ejemplo se muestran a continuaci�n:

# Clustering Methods:
#   hierarchical kmeans pam 
# 
# Cluster sizes:
#   2 3 4 5 6 
# 
# Validation Measures:
#                                 2         3         4         5         6
# 
# hierarchical Connectivity     2.9290    5.6179    8.5810   15.7345   37.2758
#              Dunn             1.5360    0.5229    0.2954    0.1630    0.1260
#              Silhouette       0.9020    0.7237    0.5564    0.4448    0.3874
# kmeans       Connectivity     2.9290   15.1385 1457.0627 2389.7679 2663.7099
#              Dunn             1.5360    0.1654    0.0271    0.0265    0.0265
#              Silhouette       0.9020    0.6221    0.1946    0.1183    0.1225
# pam          Connectivity  1423.0575 2737.5254 3417.1115 3531.2230 3623.5159
#              Dunn             0.0079    0.0080    0.0078    0.0078    0.0074
#              Silhouette       0.1868    0.1021    0.0941    0.1058    0.0967
# 
# Optimal Scores:
#   
#   Score Method       Clusters
# Connectivity 2.929 hierarchical 2       
# Dunn         1.536 hierarchical 2       
# Silhouette   0.902 hierarchical 2 


# REFERENCIAS:

# 1) Brock, Guy, Vasyl Pihur, Susmita Datta, and Somnath Datta. 2008.
# "ClValid: An R Package for Cluster Validation." Journal of Statistical 
# Software 25 (4): 1-22. https://www.jstatsoft.org/v025/i04.

