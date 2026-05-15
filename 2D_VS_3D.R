library(geomorph)
library(vegan)
library(ggplot2)
library(ggfortify)
library(dplyr)
library(car)
library(rgl)
set.seed(42)

# Import data ----
## 2D ----
landmarks2D <- readland.tps(file = "INPUT/2D.TPS", specID = "ID", readcurves = TRUE)

samples2D <- data.frame(name = rep(NA, dim(landmarks2D)[3]),
                      region = rep(NA, dim(landmarks2D)[3]),
                      country = rep(NA, dim(landmarks2D)[3]),
                      section = rep(NA, dim(landmarks2D)[3]),
                      layer = rep(NA, dim(landmarks2D)[3]),
                      chirality = rep(NA, dim(landmarks2D)[3]),
                      length = rep(NA, dim(landmarks2D)[3]))


for (i in 1:dim(landmarks2D)[3]) {
  samples2D$name[i] <- dimnames(landmarks2D)[[3]][i]
  samples2D$region[i] <- unlist(strsplit(samples2D$name[i], "_"))[1]
  samples2D$country[i] <- unlist(strsplit(samples2D$name[i], "_"))[2]
  samples2D$section[i] <- unlist(strsplit(samples2D$name[i], "_"))[3]
  samples2D$layer[i] <- unlist(strsplit(samples2D$name[i], "_"))[4]
  samples2D$chirality[i] <- unlist(strsplit(samples2D$name[i], "_"))[5]
  samples2D$length[i] <- unlist(strsplit(samples2D$name[i], "_"))[6]
} 

samples2D$region = case_when(samples2D$region == "NE" ~ "Northeastern", samples2D$region == "W"  ~ "Western")
samples2D$country = case_when(samples2D$country == "SL" ~ "Slovenia", samples2D$country == "SP"  ~ "Spain")
samples2D$section = case_when(samples2D$section == "PR" ~ "Prikrnica", samples2D$section == "BU"  ~ "Bugarra", samples2D$section == "LI"  ~ "Libros")
samples2D$chirality = case_when(samples2D$chirality == "L" ~ "sinistral", samples2D$chirality == "R"  ~ "dextral")

samples2D$region <- as.factor(samples2D$region)
samples2D$country <- as.factor(samples2D$country)
samples2D$section <- as.factor(samples2D$section)
samples2D$layer <- as.factor(samples2D$layer)
samples2D$chirality <- as.factor(samples2D$chirality)
samples2D$length <- as.numeric(samples2D$length)

## 3Dsimp ----
landmarks3Dsimp <- readland.tps(file = "INPUT/3Dsimp.TPS", specID = "ID", readcurves = TRUE)

samples3Dsimp <- data.frame(name = rep(NA, dim(landmarks3Dsimp)[3]),
                        region = rep(NA, dim(landmarks3Dsimp)[3]),
                        country = rep(NA, dim(landmarks3Dsimp)[3]),
                        section = rep(NA, dim(landmarks3Dsimp)[3]),
                        layer = rep(NA, dim(landmarks3Dsimp)[3]),
                        chirality = rep(NA, dim(landmarks3Dsimp)[3]),
                        length = rep(NA, dim(landmarks3Dsimp)[3]))


for (i in 1:dim(landmarks3Dsimp)[3]) {
  samples3Dsimp$name[i] <- dimnames(landmarks3Dsimp)[[3]][i]
  samples3Dsimp$region[i] <- unlist(strsplit(samples3Dsimp$name[i], "_"))[1]
  samples3Dsimp$country[i] <- unlist(strsplit(samples3Dsimp$name[i], "_"))[2]
  samples3Dsimp$section[i] <- unlist(strsplit(samples3Dsimp$name[i], "_"))[3]
  samples3Dsimp$layer[i] <- unlist(strsplit(samples3Dsimp$name[i], "_"))[4]
  samples3Dsimp$chirality[i] <- unlist(strsplit(samples3Dsimp$name[i], "_"))[5]
  samples3Dsimp$length[i] <- unlist(strsplit(samples3Dsimp$name[i], "_"))[6]
} 

samples3Dsimp$region = case_when(samples3Dsimp$region == "NE" ~ "Northeastern", samples3Dsimp$region == "W"  ~ "Western")
samples3Dsimp$country = case_when(samples3Dsimp$country == "SL" ~ "Slovenia", samples3Dsimp$country == "SP"  ~ "Spain")
samples3Dsimp$section = case_when(samples3Dsimp$section == "PR" ~ "Prikrnica", samples3Dsimp$section == "BU"  ~ "Bugarra", samples3Dsimp$section == "LI"  ~ "Libros")
samples3Dsimp$chirality = case_when(samples3Dsimp$chirality == "L" ~ "sinistral", samples3Dsimp$chirality == "R"  ~ "dextral")

samples3Dsimp$region <- as.factor(samples3Dsimp$region)
samples3Dsimp$country <- as.factor(samples3Dsimp$country)
samples3Dsimp$section <- as.factor(samples3Dsimp$section)
samples3Dsimp$layer <- as.factor(samples3Dsimp$layer)
samples3Dsimp$chirality <- as.factor(samples3Dsimp$chirality)
samples3Dsimp$length <- as.numeric(samples3Dsimp$length)

## 3Dall ----
landmarks3Dall <- readland.tps(file = "INPUT/3Dall.TPS", specID = "ID", readcurves = TRUE)

samples3Dall <- data.frame(name = rep(NA, dim(landmarks3Dall)[3]),
                            region = rep(NA, dim(landmarks3Dall)[3]),
                            country = rep(NA, dim(landmarks3Dall)[3]),
                            section = rep(NA, dim(landmarks3Dall)[3]),
                            layer = rep(NA, dim(landmarks3Dall)[3]),
                            chirality = rep(NA, dim(landmarks3Dall)[3]),
                            length = rep(NA, dim(landmarks3Dall)[3]))


for (i in 1:dim(landmarks3Dall)[3]) {
  samples3Dall$name[i] <- dimnames(landmarks3Dall)[[3]][i]
  samples3Dall$region[i] <- unlist(strsplit(samples3Dall$name[i], "_"))[1]
  samples3Dall$country[i] <- unlist(strsplit(samples3Dall$name[i], "_"))[2]
  samples3Dall$section[i] <- unlist(strsplit(samples3Dall$name[i], "_"))[3]
  samples3Dall$layer[i] <- unlist(strsplit(samples3Dall$name[i], "_"))[4]
  samples3Dall$chirality[i] <- unlist(strsplit(samples3Dall$name[i], "_"))[5]
  samples3Dall$length[i] <- unlist(strsplit(samples3Dall$name[i], "_"))[6]
} 

samples3Dall$region = case_when(samples3Dall$region == "NE" ~ "Northeastern", samples3Dall$region == "W"  ~ "Western")
samples3Dall$country = case_when(samples3Dall$country == "SL" ~ "Slovenia", samples3Dall$country == "SP"  ~ "Spain")
samples3Dall$section = case_when(samples3Dall$section == "PR" ~ "Prikrnica", samples3Dall$section == "BU"  ~ "Bugarra", samples3Dall$section == "LI"  ~ "Libros")
samples3Dall$chirality = case_when(samples3Dall$chirality == "L" ~ "sinistral", samples3Dall$chirality == "R"  ~ "dextral")

samples3Dall$region <- as.factor(samples3Dall$region)
samples3Dall$country <- as.factor(samples3Dall$country)
samples3Dall$section <- as.factor(samples3Dall$section)
samples3Dall$layer <- as.factor(samples3Dall$layer)
samples3Dall$chirality <- as.factor(samples3Dall$chirality)
samples3Dall$length <- as.numeric(samples3Dall$length)



# Procrustes superposition ----
## 2D ----
sliders2D <- define.sliders(3:142)
landmarks.gpa2D <- gpagen(landmarks2D, curves = sliders2D)
plot(landmarks.gpa2D)

## 3Dsimp ----
sliders3Dsimp <- define.sliders(3:142)
landmarks.gpa3Dsimp <- gpagen(landmarks3Dsimp, curves = sliders3Dsimp)
plot(landmarks.gpa3Dsimp)

## 3Dall ----
sliders3Dall <- define.sliders(7:226)
landmarks.gpa3Dall <-gpagen(landmarks3Dall, curves = sliders3Dall)
plot(landmarks.gpa3Dall)


# Principal Component Analysis ----
## 2D ----
PCA_2D <- gm.prcomp(landmarks.gpa2D$coords)
plot(PCA_2D)
summary(PCA_2D)

PC1 <- PCA_2D$x[, 1]
samples2D$PC1 <- PC1
PC2 <- PCA_2D$x[, 2]
samples2D$PC2 <- PC2


morphospace_2D <- ggplot(samples2D, aes(x = PC1, y = PC2)) +
  geom_point(
    shape = 21, fill = "#47479fff", color = "black", size = 5) +
  labs(
    x = "PC1 (29.99%)",
    y = "PC2 (16.47%)"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  )


# ggsave("OUTPUT/morphospace/2D.jpg",morphospace_2D, width=170, height=100, units="mm", dpi = 300)

### representation of information by PCA ----
screeplot(PCA_2D, type = "bar", npcs = 30)

## 3Dsimp ----
PCA_3Dsimp <- gm.prcomp(landmarks.gpa3Dsimp$coords)
plot(PCA_3Dsimp)
summary(PCA_3Dsimp)

PC1 <- PCA_3Dsimp$x[, 1]
samples3Dsimp$PC1 <- PC1
PC2 <- PCA_3Dsimp$x[, 2]
samples3Dsimp$PC2 <- PC2

morphospace_3Dsimp <- ggplot(samples3Dsimp, aes(x = PC1, y = PC2)) +
  geom_point(
    shape = 21, fill = "#227a22ff", color = "black", size = 5) +
  labs(
    x = "PC1 (33.98%)",
    y = "PC2 (19.13%)"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  )


# ggsave("OUTPUT/morphospace/3Dsimp.jpg",morphospace_3Dsimp, width=170, height=100, units="mm", dpi = 300)

### representation of information by PCA ----
screeplot(PCA_3Dsimp, type = "bar", npcs = 30)


## 3Dall ----
PCA_3Dall <- gm.prcomp(landmarks.gpa3Dall$coords)
plot(PCA_3Dall)
summary(PCA_3Dall)

PC1 <- PCA_3Dall$x[, 1]
samples3Dall$PC1 <- PC1
PC2 <- PCA_3Dall$x[, 2]
samples3Dall$PC2 <- PC2

morphospace_3Dall <- ggplot(samples3Dall, aes(x = PC1, y = PC2)) +
  geom_point(
    shape = 21, fill = "#ffaf4dff", color = "black", size = 5) +
  labs(
    x = "PC1 (28.17%)",
    y = "PC2 (14.19%)"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  )

# ggsave("OUTPUT/morphospace/3Dall.jpg",morphospace_3Dall, width=170, height=100, units="mm", dpi = 300)

### representation of information by PCA ----
screeplot(PCA_3Dall, type = "bar", npcs = 30)


# Exploratory Data Analysis ----
## Length ----
### Outlier detection ----
# jpeg("OUTPUT/Exploratory Data Analysis/Length distribution_boxplot.jpg", width = 1700, height = 1000, res = 300)
par(mfrow = c(1, 3))

#### 2D ----
boxplot(samples2D$length, main = "2D dataset", ylab = "Length (µm)")

#### 3Dsimp ----
boxplot(samples3Dsimp$length, main = "3Dsimp dataset")

#### 3Dall ----
boxplot(samples3Dall$length, main = "3Dall dataset")

# dev.off()

### Normality ----
# jpeg("OUTPUT/Exploratory Data Analysis/Length distribution_hist.jpg", width = 1700, height = 1000, res = 300)
par(mfrow = c(1, 3))
#### 2D ----
hist(samples2D$length, main = "2D dataset")
shapiro.test(samples2D$length)

#### 3Dsimp ----
hist(samples3Dsimp$length, main = "3Dsimp dataset")
shapiro.test(samples3Dsimp$length)

#### 3Dall ----
hist(samples3Dall$length, main = "3Dall dataset")
shapiro.test(samples3Dall$length)

# dev.off()
par(mfrow = c(1, 1))


## PC1 ----
### Outlier detection ----
# jpeg("OUTPUT/Exploratory Data Analysis/PC1 distribution_boxplot.jpg", width = 1700, height = 1000, res = 300)
par(mfrow = c(1, 3))
#### 2D ----
boxplot(samples2D$PC1, main = "2D dataset", ylab = "PC1")

#### 3Dsimp ----
boxplot(samples3Dsimp$PC1, main = "3Dsimp dataset")

#### 3Dall ----
boxplot(samples3Dall$PC1, main = "3Dall dataset")

# dev.off()

## Normality ----
# jpeg("OUTPUT/Exploratory Data Analysis/PC1 distribution_hist.jpg", width = 1700, height = 1000, res = 300)
par(mfrow = c(1, 3))
### 2D ----
hist(samples2D$PC1, main = "2D dataset")
shapiro.test(samples2D$PC1)

### 3Dsimp ----
hist(samples3Dsimp$PC1, main = "3Dsimp dataset")
shapiro.test(samples3Dsimp$PC1)

### 3Dall ----
hist(samples3Dall$PC1, main = "3Dall dataset")
shapiro.test(samples3Dall$PC1)

# dev.off()
par(mfrow = c(1, 1))



# Chirality (detecting differences) ----
## Length ----
### 2D ----
ggplot(data = samples2D, aes(x = chirality, y = length)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  labs(x = "", y = "Length (µm)") +
  theme_bw()

t.test(length ~ chirality, data = samples2D)

### 3Dsimp ----
ggplot(data = samples3Dsimp, aes(x = chirality, y = length)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  labs(x = "", y = "Length (µm)") +
  theme_bw()

t.test(length ~ chirality, data = samples3Dsimp)

### 3Dall ----
ggplot(data = samples3Dall, aes(x = chirality, y = length)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  labs(x = "", y = "Length (µm)") +
  theme_bw()


t.test(length ~ chirality, data = samples3Dall)


## PC1 ----
### 2D ----
#### Homogeneity of variance ----
ggplot(data = samples2D, aes(x = chirality, y = PC1)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  labs(x = "", y = "PC1") +
  theme_bw()

leveneTest(PC1 ~ chirality, data = samples2D)

#### Mean shape ----
mean_shape_left_2D <- geomorph::mshape(landmarks.gpa2D$coords[, , samples2D$chirality == "sinistral"])
mean_shape_right_2D <- geomorph::mshape(landmarks.gpa2D$coords[, , samples2D$chirality == "dextral"])

plot(mean_shape_left_2D, main = "Mean Shape: Left (Sinistral)")
plot(mean_shape_right_2D, main = "Mean Shape: Right (Dextral)")

#### morpho. disparity ----
morphol.disparity(coords ~ 1, groups = samples2D$chirality, 
                  data = landmarks.gpa2D,  
                  print.progress = TRUE)


### 3Dsimp ----
#### Homogeneity of variance ----
ggplot(data = samples3Dsimp, aes(x = chirality, y = PC1)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  labs(x = "", y = "PC1") +
  theme_bw()

leveneTest(PC1 ~ chirality, data = samples3Dsimp)

#### Mean shape ----
mean_shape_left_3Dsimp <- geomorph::mshape(landmarks.gpa3Dsimp$coords[, , samples3Dsimp$chirality == "sinistral"])
mean_shape_right_3Dsimp <- geomorph::mshape(landmarks.gpa3Dsimp$coords[, , samples3Dsimp$chirality == "dextral"])

plot(mean_shape_left_3Dsimp, main = "Mean Shape: Left (Sinistral)")
plot(mean_shape_right_3Dsimp, main = "Mean Shape: Right (Dextral)")

#### morpho. disparity ----
morphol.disparity(coords ~ 1, groups = samples3Dsimp$chirality, 
                  data = landmarks.gpa3Dsimp,  
                  print.progress = TRUE)


### 3Dall ----
#### Homogeneity of variance ----
ggplot(data = samples3Dall, aes(x = chirality, y = PC1)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  labs(x = "", y = "PC1") +
  theme_bw()

leveneTest(PC1 ~ chirality, data = samples3Dall)

#### Mean shape ----
mean_shape_left_3Dall <- geomorph::mshape(landmarks.gpa3Dall$coords[, , samples3Dall$chirality == "sinistral"])
mean_shape_right_3Dall <- geomorph::mshape(landmarks.gpa3Dall$coords[, , samples3Dall$chirality == "dextral"])

plot(mean_shape_left_3Dall, main = "Mean Shape: Left (Sinistral)")
plot(mean_shape_right_3Dall, main = "Mean Shape: Right (Dextral)")

#### morpho. disparity ----
morphol.disparity(coords ~ 1, groups = samples3Dall$chirality, 
                  data = landmarks.gpa3Dall,  
                  print.progress = TRUE)




# Shape ----
## Mean shape ----
### 2D ----
msho2D <- mshape(landmarks.gpa2D$coords)
# jpeg("OUTPUT/Shape/Mean_shape_2D.jpeg", width = 800, height = 600)
plot(msho2D)
# dev.off()

### 3Dsimp ----
msho3Dsimp <- mshape(landmarks.gpa3Dsimp$coords)
plot(msho3Dsimp)
# rgl.snapshot("OUTPUT/Shape/Mean_shape_3Dsimp/oral.png")


### 3Dall ----
msho3Dall <- mshape(landmarks.gpa3Dall$coords)
plot(msho3Dall)
#rgl.snapshot("OUTPUT/Shape/Mean_shape_3Dall/oral.png")


## Extremes of PC1 and PC2 ----
### 2D ----
# jpeg("OUTPUT/Shape/Extreme_values_2D.jpeg", width = 2000, height = 2000, res = 300)
# par(mfrow = c(2, 2))

plotRefToTarget(PCA_2D$shapes$shapes.comp1$min, msho2D, method = "vector")
plotRefToTarget(PCA_2D$shapes$shapes.comp1$max, msho2D, method = "vector")
plotRefToTarget(PCA_2D$shapes$shapes.comp2$min, msho2D, method = "vector")
plotRefToTarget(PCA_2D$shapes$shapes.comp2$max, msho2D, method = "vector")

#dev.off()

### 3Dsimp ----
plotRefToTarget(PCA_3Dsimp$shapes$shapes.comp1$min, msho3Dsimp, method = "vector")
plotRefToTarget(PCA_3Dsimp$shapes$shapes.comp1$max, msho3Dsimp, method = "vector")
plotRefToTarget(PCA_3Dsimp$shapes$shapes.comp2$min, msho3Dsimp, method = "vector")
plotRefToTarget(PCA_3Dsimp$shapes$shapes.comp2$max, msho3Dsimp, method = "vector")

# rgl.snapshot("OUTPUT/Shape/Extreme_values_3Dsimp/PC2_max_rostral.png")


### 3Dall ----
plotRefToTarget(PCA_3Dall$shapes$shapes.comp1$min, msho3Dall, method = "vector")
plotRefToTarget(PCA_3Dall$shapes$shapes.comp1$max, msho3Dall, method = "vector")
plotRefToTarget(PCA_3Dall$shapes$shapes.comp2$min, msho3Dall, method = "vector")
plotRefToTarget(PCA_3Dall$shapes$shapes.comp2$max, msho3Dall, method = "vector")

# rgl.snapshot("OUTPUT/Shape/Extreme_values_3Dall/PC2_min_oral.png")


# Comparison 2D vs 3D ----
## 2D vs 3Dsimp ----
protest(X = PCA_2D$x[,1:8], Y = PCA_3Dsimp$x[,1:8], permutations = 9999)


## 2D vs 3Dall ----
protest(X = PCA_2D$x[,1:8], Y = PCA_3Dall$x[,1:8], permutations = 9999)


## 3Dsimp vs 3Dall ----
protest(X = PCA_3Dsimp$x[,1:8], Y = PCA_3Dall$x[,1:8], permutations = 9999)


