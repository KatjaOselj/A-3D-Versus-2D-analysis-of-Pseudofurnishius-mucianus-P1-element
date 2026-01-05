library(geomorph)
library(lattice)
library(dplyr)

# Import landmarks into R ----
landmarks2D <- readland.tps(file = "2D.TPS", specID = "ID", readcurves = TRUE)
landmarks3D <- readland.tps(file = "3D.TPS", specID = "ID", readcurves = TRUE)

## Generate a data frame ----
### 2D ----
samples2D <- data.frame(name = rep(NA, dim(landmarks2D)[3]),
                        part = rep(NA, dim(landmarks2D)[3]),
                        country = rep(NA, dim(landmarks2D)[3]),
                        section = rep(NA, dim(landmarks2D)[3]),
                        layer = rep(NA, dim(landmarks2D)[3]),
                        chirality = rep(NA, dim(landmarks2D)[3]),
                        facieszone = rep(NA, dim(landmarks2D)[3]),
                        length = rep(NA, dim(landmarks2D)[3]))


for (i in 1:dim(landmarks2D)[3]) {
  samples2D$name[i] <- dimnames(landmarks2D)[[3]][i]
  samples2D$part[i] <- unlist(strsplit(samples2D$name[i], "_"))[1]
  samples2D$country[i] <- unlist(strsplit(samples2D$name[i], "_"))[2]
  samples2D$section[i] <- unlist(strsplit(samples2D$name[i], "_"))[3]
  samples2D$layer[i] <- unlist(strsplit(samples2D$name[i], "_"))[4]
  samples2D$chirality[i] <- unlist(strsplit(samples2D$name[i], "_"))[5]
  samples2D$facieszone[i] <- unlist(strsplit(samples2D$name[i], "_"))[6]
  samples2D$length[i] <- unlist(strsplit(samples2D$name[i], "_"))[7]
} 

samples2D$part = case_when(samples2D$part == "NE" ~ "Northeastern", 
                           samples2D$part == "W"  ~ "Western")
samples2D$country = case_when(samples2D$country == "SL" ~ "Slovenia", 
                              samples2D$country == "SP"  ~ "Spain")
samples2D$section = case_when(samples2D$section == "PR" ~ "Prikrnica", 
                              samples2D$section == "BU"  ~ "Bugarra", 
                              samples2D$section == "LI"  ~ "Libros")
samples2D$chirality = case_when(samples2D$chirality == "L" ~ "sinistral", 
                                samples2D$chirality == "R"  ~ "dextral")
samples2D$facieszone = case_when(samples2D$facieszone == "FZ3" ~ "facies zone 3", 
                                 samples2D$facieszone == "FZ8"  ~ "facies zone 8")

samples2D$part <- as.factor(samples2D$part)
samples2D$country <- as.factor(samples2D$country)
samples2D$section <- as.factor(samples2D$section)
samples2D$layer <- as.factor(samples2D$layer)
samples2D$chirality <- as.factor(samples2D$chirality)
samples2D$facieszone <- as.factor(samples2D$facieszone)
samples2D$length <- as.numeric(samples2D$length)


### 3D ----
samples3D <- data.frame(name = rep(NA, dim(landmarks3D)[3]),
                        part = rep(NA, dim(landmarks3D)[3]),
                        country = rep(NA, dim(landmarks3D)[3]),
                        section = rep(NA, dim(landmarks3D)[3]),
                        layer = rep(NA, dim(landmarks3D)[3]),
                        chirality = rep(NA, dim(landmarks3D)[3]),
                        facieszone = rep(NA, dim(landmarks3D)[3]))

for (i in 1:dim(landmarks3D)[3]) {
  samples3D$name[i] <- dimnames(landmarks3D)[[3]][i]
  samples3D$part[i] <- unlist(strsplit(samples3D$name[i], "_"))[1]
  samples3D$country[i] <- unlist(strsplit(samples3D$name[i], "_"))[2]
  samples3D$section[i] <- unlist(strsplit(samples3D$name[i], "_"))[3]
  samples3D$layer[i] <- unlist(strsplit(samples3D$name[i], "_"))[4]
  samples3D$chirality[i] <- unlist(strsplit(samples3D$name[i], "_"))[5]
  samples3D$facieszone[i] <- unlist(strsplit(samples3D$name[i], "_"))[6]
} 

samples3D$part = case_when(samples3D$part == "NE" ~ "Northeastern", 
                           samples3D$part == "W"  ~ "Western")
samples3D$country = case_when(samples3D$country == "SL" ~ "Slovenia", 
                              samples3D$country == "SP"  ~ "Spain")
samples3D$section = case_when(samples3D$section == "PR" ~ "Prikrnica", 
                              samples3D$section == "BU"  ~ "Bugarra", 
                              samples3D$section == "LI"  ~ "Libros")
samples3D$chirality = case_when(samples3D$chirality == "L" ~ "sinistral", 
                                samples3D$chirality == "R"  ~ "dextral")
samples3D$facieszone = case_when(samples3D$facieszone == "FZ3" ~ "facies zone 3", 
                                 samples3D$facieszone == "FZ8"  ~ "facies zone 8")


samples3D$part <- as.factor(samples3D$part)
samples3D$country <- as.factor(samples3D$country)
samples3D$section <- as.factor(samples3D$section)
samples3D$layer <- as.factor(samples3D$layer)
samples3D$chirality <- as.factor(samples3D$chirality)
samples3D$facieszone <- as.factor(samples3D$facieszone)

#### Length of 3D models ---- 
ventral <- landmarks3D[1,,]
dorsal <- landmarks3D[2,,]

length <- sqrt(colSums((ventral - dorsal)^2))

samples3D$length <- length


### Basic inquiry ----
samples2D
str(samples2D)
table(samples2D$part)

samples3D
str(samples3D)
table(samples3D$part)

## Length ----
summary(samples2D$length)
summary(samples3D$length)
boxplot(samples2D$length, samples3D$length)

# Procrustes analysis ----
## 2D ----
sliders2D <- define.sliders(3:140)
landmarks.gpa2D <- gpagen(landmarks2D, curves = sliders2D)
plot(landmarks.gpa2D)
## 3D ----
sliders3D <- define.sliders(7:96)
landmarks.gpa3D <- gpagen(landmarks3D, curves = sliders3D)
plot(landmarks.gpa3D)


# Principal Component Analysis ----
## 2D ----
PCA_2D <- gm.prcomp(landmarks.gpa2D$coords)
plot(PCA_2D)
summary(PCA_2D)
PC1 <- PCA_2D$x[, 1]
PC2 <- PCA_2D$x[, 2]
samples2D$PC1 <- PC1
samples2D$PC2 <- PC2

## 3D ----
PCA_3D <- gm.prcomp(landmarks.gpa3D$coords)
plot(PCA_3D)
summary(PCA_3D)
PC1 <- PCA_3D$x[, 1]
PC2 <- PCA_3D$x[, 2]
samples3D$PC1 <- PC1
samples3D$PC2 <- PC2


# Shape ----
## Mean shape ----
### 2D ----
msho2D <- mshape(landmarks.gpa2D$coords)
plot(msho2D)
### 3D ----
msho3D <- mshape(landmarks.gpa3D$coords)
plot(msho3D)


## Extremes of PC1 and PC2 ----
### 2D ----
plotRefToTarget(PCA_2D$shapes$shapes.comp1$min, msho2D, method = "vector")
title("PC1 Minimum Shape")
plotRefToTarget(PCA_2D$shapes$shapes.comp1$max, msho2D, method = "vector")
title("PC1 Maximum Shape")
plotRefToTarget(PCA_2D$shapes$shapes.comp2$min, msho2D, method = "vector")
title("PC2 Minimum Shape")
plotRefToTarget(PCA_2D$shapes$shapes.comp2$max, msho2D, method = "vector")
title("PC2 Maximum Shape")

### 3D ----
plotRefToTarget(PCA_3D$shapes$shapes.comp1$min, msho3D,
                method = "vector")
plotRefToTarget(PCA_3D$shapes$shapes.comp1$max, msho3D,
                method = "vector")
plotRefToTarget(PCA_3D$shapes$shapes.comp2$min, msho3D,
                method = "vector")
plotRefToTarget(PCA_3D$shapes$shapes.comp2$max, msho3D,
                method = "vector")

# Normality of data set ----
## PC1 results ----
### 2D ----
summary(samples2D$PC1)
hist(samples2D$PC1)
shapiro.test(samples2D$PC1)
#### Part of the Sephardic province ----
histogram(~ PC1 | part, data = samples2D)
shapiro_results <- tapply(samples2D$PC1, samples2D$part, shapiro.test)
shapiro_results
#### Section ----
histogram(~ PC1 | section, data = samples2D)
shapiro_results <- tapply(samples2D$PC1, samples2D$section, shapiro.test)
shapiro_results

### 3D ----
summary(samples3D$PC1)
hist(samples3D$PC1)
shapiro.test(samples3D$PC1)
#### Part of the Sephardic province ----
histogram(~ PC1 | part, data = samples3D)
shapiro_results <- tapply(samples3D$PC1, samples3D$part, shapiro.test)
shapiro_results
#### Section ----
histogram(~ PC1 | section, data = samples3D)
shapiro_results <- tapply(samples3D$PC1, samples3D$section, shapiro.test)
shapiro_results

## Length ----
### 2D ----
summary(samples2D$length)
hist(samples2D$length)
shapiro.test(samples2D$length)
#### Part of the Sephardic province ----
histogram(~ length | part, data = samples2D)
shapiro_results <- tapply(samples2D$length, samples2D$part, shapiro.test)
shapiro_results
#### Section ----
histogram(~ length | section, data = samples2D)
shapiro_results <- tapply(samples2D$length, samples2D$section, shapiro.test)
shapiro_results

### 3D ----
summary(samples3D$length)
hist(samples3D$length)
shapiro.test(samples3D$length)
#### Part of the Sephardic province ----
histogram(~ length | part, data = samples3D)
shapiro_results <- tapply(samples3D$length, samples3D$part, shapiro.test)
shapiro_results
#### Section ----
histogram(~ length | section, data = samples3D)
shapiro_results <- tapply(samples3D$length, samples3D$section, shapiro.test)
shapiro_results




# Scatter plot of PC1 and PC2 ----
## 2D ----
### by part ----
plot(PCA_2D$x[,1], PCA_2D$x[,2],
     pch = c(16, 15)[samples2D$part],
     col = c("grey","#0033A0")[samples2D$part],
     xlab = "PC 1",
     ylab = "PC 2",
     main = "Morphospace of the P. murcianus")
legend(x = "bottomleft",
       legend = levels(samples2D$part),
       pch = c(16, 15),
       col = c("grey","#0033A0"),
       title = "Part of the Sephardic province")

### by section ---- 
plot(PCA_2D$x[,1], PCA_2D$x[,2],
     pch = c(16, 15, 17)[samples2D$section],
     col = c("#0033A0","#91bfdb","grey")[samples2D$section],
     xlab = "PC 1",
     ylab = "PC 2",
     main = "Morphospace of P. murcianus")
legend(x = "bottomleft",
       legend = levels(samples2D$section),
       pch = c(16, 15, 17),
       col = c("#0033A0","#91bfdb","grey"),
       title = "Section")

## 3D ----
### by part ----
plot(PCA_3D$x[,1], PCA_3D$x[,2],
     pch = c(16, 15)[samples3D$part],
     col = c("grey","#0033A0")[samples3D$part],
     xlab = "PC 1",
     ylab = "PC 2",
     main = "Morphospace of the P. murcianus")
legend(x = "bottomleft",
       legend = levels(samples3D$part),
       pch = c(16, 15),
       col = c("grey","#0033A0"),
       title = "Part of the Sephardic province")

### by section ---- 
plot(PCA_3D$x[,1], PCA_3D$x[,2],
     pch = c(16, 15, 17)[samples3D$section],
     col = c("#0033A0","#91bfdb","grey")[samples3D$section],
     xlab = "PC 1",
     ylab = "PC 2",
     main = "Morphospace of P. murcianus")
legend(x = "bottomleft",
       legend = levels(samples3D$section),
       pch = c(16, 15, 17),
       col = c("#0033A0","#91bfdb","grey"),
       title = "Section")


# Morphological disparity ----
## 2D ----
morphol.disparity(coords ~ 1, groups = samples2D$section, 
                  data = landmarks.gpa2D,  
                  print.progress = TRUE)

morphol.disparity(coords ~ 1, groups = samples2D$part, 
                  data = landmarks.gpa2D,  
                  print.progress = TRUE)

## 3D ---- 
morphol.disparity(coords ~ 1, groups = samples3D$section, 
                  data = landmarks.gpa3D,  
                  print.progress = TRUE)

morphol.disparity(coords ~ 1, groups = samples3D$part, 
                  data = landmarks.gpa3D,  
                  print.progress = TRUE)

