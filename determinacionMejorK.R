# Codigo dirigido a estudiantes del curso:
# Miner�a de Datos. Universidad de Talca.-

# Con este c�digo se pretender responder la siguiente pregunta:
# �C�mo determinar el n�mero de cluster?

# Existen diferentes indices para determinar la calidad de un cluster. Es posible 
# utilizar estos valores para comparar estructuras y seleccionar la que obtiene mejores resultados.
# En general, el indice que se debe utilizar depende del tipo de datos que la base de datos
# posee. Sin embargo, en este tutorial, presentar� una metodolog�a automatizada y gen�rica 
# que permitir� determinar el n�mero de clusters que asegura el mejor desempe�o frente al mayor n�mero de
# �ndices.

# Para ejemplificar su uso, utilizaremos la base de datos "dataForTesting_1.csv" disponible en el curso.
library(readr)
Data <- read_csv("/Users/pablo/Desktop/analisisExploratorio/dataForTesting_1.csv", 
                 col_names = FALSE)
View(Data)

# Para cumplir el objetivo planteado, utilizaremos la librer�a "nBClust". Este paquete incluye 30 indices 
# de calidad de cluster. La descripci�n detallada de los indices puede ser encontrada en el art�culo [1]. 
# Este paper se encuentra disponible en la carpeta de material complementario del curso.


library("NbClust")


# OJO: esto puede tardar dependiendo de la capacidad de procesamiento de su computador.
result <- NbClust(Data, diss = NULL, distance = "euclidean", min.nc = 2, max.nc = 6, 
                  method = "kmean", index = "all")

# Los principales par�metros son los siguientes:
# 1) tipo de distancia
# 2) n�mero m�nimo y m�ximo de clusters a evaluar (min.nc y max.nc)
# 3) el algoritmo que se utilizar�: Usted puede seleccionar un m�todo en espef�cio. #VER: ?NbClust
# 4) seleccionar los indices que desea utilizar. Al seleccionar "all" se ejecutar�n todos los �ndices.



#RESULTADOS: 

# Pegar� los resultados textuales a continuaci�n. Las primeras l�neas indican que 11 de los �ndices sugieren 
# utilizar k = 2. Por lo tanto, este es el n�mero de cluster que debe aplicar.

# * Among all indices:                                                
#   * 11 proposed 2 as the best number of clusters 
# * 6 proposed 3 as the best number of clusters 
# * 2 proposed 5 as the best number of clusters 
# * 4 proposed 6 as the best number of clusters 
# 
# ***** Conclusion *****                            
#   
#   * According to the majority rule, the best number of clusters is  2 
# 
# 
# ******************************************************************* 
#   $All.index
# KL        CH Hartigan     CCC    Scott        Marriot  TrCovW   TraceW      Friedman  Rubin Cindex
# 2 3.8067 1524.3889 465.3816 75.4066      NaN -6.286658e+103 4212430 48481.30 -2.278151e+13 1.5671 0.0819
# 3 1.4387 1057.4566 336.3684 43.2338      NaN -4.594861e+103 3468438 44793.07 -3.550758e+13 1.6961 0.0777
# 4 1.1142  858.9043 305.6987 40.4286 190021.9  6.331283e+103 2899855 42276.61  2.927978e+13 1.7971 0.0738
# 5 1.3963  755.3231 229.4261 42.7208 205868.0  5.999921e+102 2520899 40106.60  2.955805e+14 1.8943 0.0731
# 6 0.5780  674.5654 385.3195 44.4685      NaN -5.739564e+102 2288826 38541.30 -2.919048e+14 1.9713 0.0709
# DB Silhouette   Duda  Pseudot2    Beale Ratkowsky      Ball Ptbiserial    Frey McClain   Dunn Hubert
# 2 1.9140     0.1921 1.3648 -868.6282 -10.8519    0.0712 24240.650     0.2884  0.6723  0.7849 0.0084  0e+00
# 3 2.4206     0.1149 1.3734 -943.7469 -11.0383    0.0691 14931.024     0.2930  0.5882  1.4418 0.0082  0e+00
# 4 2.4079     0.1060 1.4862 -748.5030 -13.2785    0.0699 10569.153     0.2858  0.6396  2.0546 0.0044  0e+00
# 5 2.3604     0.1048 1.6968 -740.4264 -16.6671    0.0804  8021.321     0.2687  0.3292  2.8998 0.0068  1e-04
# 6 2.2889     0.1000 1.1380 -152.3155  -4.9207    0.0773  6423.551     0.2637 -0.0078  3.5534 0.0062  1e-04
# SDindex Dindex   SDbw
# 2  1.5285 2.7088 2.7939
# 3  1.9055 2.5964 0.7946
# 4  1.8288 2.5228 0.8062
# 5  1.8793 2.4491 0.7597
# 6  1.9353 2.3991 0.7577
# 
# $All.CriticalValues
# CritValue_Duda CritValue_PseudoT2 Fvalue_Beale
# 2         0.9771            76.3382            1
# 3         0.9753            88.0262            1
# 4         0.9728            63.9479            1
# 5         0.9718            52.2282            1
# 6         0.9695            39.4832            1
# 
# $Best.nc
# KL       CH Hartigan     CCC    Scott       Marriot   TrCovW   TraceW     Friedman
# Number_clusters 2.0000    2.000   6.0000  2.0000     5.00  3.000000e+00      3.0    3.000 6.000000e+00
# Value_Index     3.8067 1524.389 155.8934 75.4066 15846.06 9.234347e+103 743992.2 1171.769 5.874853e+14
# Rubin Cindex    DB Silhouette   Duda  PseudoT2    Beale Ratkowsky     Ball PtBiserial Frey
# Number_clusters  3.0000 6.0000 2.000     2.0000 2.0000    2.0000   2.0000    5.0000    3.000      3.000    1
# Value_Index     -0.0281 0.0709 1.914     0.1921 1.3648 -868.6282 -10.8519    0.0804 9309.626      0.293   NA
# McClain   Dunn Hubert SDindex Dindex   SDbw
# Number_clusters  2.0000 2.0000      0  2.0000      0 6.0000
# Value_Index      0.7849 0.0084      0  1.5285      0 0.7577
# 
# $Best.partition
# [1] 2 2 2 2 2 2 2 2 1 1 2 1 1 2 2 2 2 2 2 2 2 1 2 1 1 1 1 2 1 1 1 1 1 1 2 2 1 1 1 2 1 1 2 1 1 1 1 1 1 1 1 1
# [53] 1 1 2 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 2 2 1 1 1 1 1 1 1 1 1 1
# [105] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 2 1 1 2 1 1 1 1 1 1 2 1 2 1 1 2 1
# [157] 1 2 1 2 1 1 1 1 1 1 2 2 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 1 1 1 1 1 1 2 2 2 2 1 1 1 1 1
# [209] 2 2 2 2 1 1 1 2 1 2 2 1 2 1 1 1 1 1 2 1 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 2 1 2 1 1 2 2 1 2 1 1 2 1 1 1
# [261] 1 1 1 1 2 2 1 2 1 1 1 1 1 1 2 1 2 1 1 1 1 1 1 1 1 2 1 2 2 1 1 1 1 1 1 2 2 2 1 1 1 1 2 2 2 2 1 1 1 2 2 1
# [313] 2 1 1 1 2 2 2 1 1 2 1 1 2 2 1 2 2 1 2 1 2 1 1 1 1 2 2 2 2 1 2 2 1 1 2 1 1 1 2 2 2 2 2 2 1 1 2 2 2 2 2 2
# [365] 2 2 2 1 2 1 1 2 2 1 1 1 2 1 2 2 1 2 2 2 2 1 2 1 2 2 2 1 2 1 2 1 1 2 2 2 2 2 1 2 2 1 2 2 2 2 2 2 2 2 1 2
# [417] 2 2 1 2 2 2 2 1 2 2 2 1 2 2 2 2 2 2 1 1 2 2 2 1 2 2 2 1 2 2 2 1 2 2 2 2 2 2 2 2 2 1 2 2 1 2 1 2 2 1 2 1
# [469] 2 1 1 2 1 2 1 1 2 1 2 1 2 1 1 1 2 2 1 1 2 2 1 1 2 2 2 2 2 2 2 1 2 2 1 2 1 2 1 1 2 2 2 2 2 2 2 1 2 1 2 2
# [521] 2 2 1 2 1 1 1 1 2 2 2 2 2 2 1 1 2 2 2 1 2 2 1 1 2 2 2 1 2 2 2 2 2 1 2 2 1 1 1 2 2 2 2 2 2 1 1 1 2 2 1 1
# [573] 1 2 1 2 2 2 2 1 2 2 2 1 1 1 1 2 2 1 1 1 1 1 2 1 2 1 1 2 1 1 2 2 1 2 2 2 1 2 1 1 2 1 1 2 2 2 2 2 1 2 1 2
# [625] 2 2 1 1 2 2 2 2 2 1 2 2 2 2 2 2 2 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2
# [677] 1 2 1 1 2 2 2 1 2 2 2 1 1 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 1 2 1 2 2 2 1 2 2 2 2 2 2 1 2 2 1 2 1
# [729] 2 2 1 2 2 2 1 2 2 2 1 1 1 1 2 2 1 1 2 1 2 2 2 2 1 2 2 2 2 1 1 2 2 2 2 2 2 2 1 2 2 2 2 2 1 1 2 1 2 2 2 2
# [781] 2 2 1 1 2 2 1 2 1 2 2 2 2 2 1 1 2 2 2 2 2 1 1 2 1 1 1 1 1 1 1 2 2 1 2 2 1 2 2 2 2 2 1 1 1 1 2 2 2 2 1 2
# [833] 2 2 1 2 1 2 2 1 1 1 2 2 2 1 2 1 1 2 1 2 1 2 1 1 1 1 1 2 1 1 2 2 2 2 2 1 2 2 2 2 2 2 1 2 1 1 2 1 1 2 2 2
# [885] 1 2 2 2 2 2 2 1 2 2 1 2 2 1 2 2 2 1 2 2 1 2 1 1 1 1 2 2 2 2 2 1 2 1 2 2 1 2 2 2 1 2 1 2 1 1 1 2 2 2 1 1
# [937] 2 1 1 1 1 1 1 1 2 2 2 2 1 2 2 2 2 2 2 2 2 1 2 2 1 2 2 2 2 1 2 1 2 1 2 1 2 2 2 2 1 2 2 2 1 2 1 2 2 2 2 2
# [989] 2 1 2 2 2 2 2 2 2 1 2 2
# [ reached getOption("max.print") -- omitted 4654 entries ]

# REFERENCIAS

# [1] # Malika, C., Ghazzali, N., Boiteau, V., & Niknafs, A. (2014). NbClust: an R package for determining
# the relevant number of clusters in a data Set. J. Stat. Softw, 61, 1-36.


# OJO! Recuerden que esta no es la �nica forma para realizar este tipo de an�lisis. Existen otras
# librerias y softwares evolucionando cada d�a. Esto es solo una referencia para que usted
# pueda comenzar en el mundo de la Miner�a de Datos.

# Si usted tiene alguna pregunta, no dude en contactarme:
# jgutierrezb@utalca.cl
