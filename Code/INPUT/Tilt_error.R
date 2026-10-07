library(geomorph)
library(ggplot2)
library(dplyr)
library("plot3D")

# Import data ----

Tilt <- readland.tps(file = "INPUT/Tilt_error.TPS", specID = "ID", readcurves = TRUE)

Tilt_df <- data.frame(name = rep(NA, dim(Tilt)[3]),
                        specimen = rep(NA, dim(Tilt)[3]),
                        orientation = rep(NA, dim(Tilt)[3]))


for (i in 1:dim(Tilt)[3]) {
  Tilt_df$name[i] <- dimnames(Tilt)[[3]][i]
  Tilt_df$specimen[i] <- unlist(strsplit(Tilt_df$name[i], "_"))[1]
  Tilt_df$orientation[i] <- unlist(strsplit(Tilt_df$name[i], "_"))[2]
} 


Tilt_df$specimen <- factor(Tilt_df$specimen)
Tilt_df$orientation <- factor(Tilt_df$orientation)

# Procrustes superposition ----
sliders_tilt <- define.sliders(3:142)
landmarks.gpaTilt <- gpagen(Tilt, curves = sliders_tilt)
plot(landmarks.gpaTilt)


PCA_Tilt <- gm.prcomp(landmarks.gpaTilt$coords)
plot(PCA_Tilt)
summary(PCA_Tilt)

PC1 <- PCA_Tilt$x[, 1]
Tilt_df$PC1 <- PC1
PC2 <- PCA_Tilt$x[, 2]
Tilt_df$PC2 <- PC2
PC3 <- PCA_Tilt$x[, 3]
Tilt_df$PC3 <- PC3

ggplot(Tilt_df, aes(x = PC1, y = PC2, colour = orientation)) +
  geom_point(size=5) +
  labs(
    x = "PC1",
    y = "PC2"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  )


scatter3D_2D <- function(x, y, z, ..., colvar = NULL) {
  panelfirst <- function(pmat) {
    XY <- trans3D(x, y, z = rep(min(z), length(z)), pmat = pmat)
    scatter2D(XY$x, XY$y, col = "#47479fff", pch = ".",
              cex = 2, add = TRUE, colkey = FALSE)
    XY <- trans3D(x = rep(min(x), length(x)), y, z, pmat = pmat)
    scatter2D(XY$x, XY$y, col = "#47479fff", pch = ".",
              cex = 2, add = TRUE, colkey = FALSE)
  }
  scatter3D(x, y, z, ..., col = "#47479fff", panel.first = panelfirst,
            colkey = FALSE)
}
cols <- c(
  caudal = "#47479fff",
  ref = "lightcoral",
  rostral = "#227a22ff"
)

point_col <- cols[as.character(Tilt_df$orientation)]

scatter3D(x = Tilt_df$PC2, y = Tilt_df$PC1, z = Tilt_df$PC3,  col = point_col,  pch = 19, cex = 1.5, bty = "g", xlab = "PC2 (26%)", ylab = "PC1 (29%)", zlab = "PC3 (16%)", ticktype = "detailed", theta = 45, phi = 20, d = 2, colkey = FALSE)

legend(
  "topright",
  legend = c("caudal", "ref", "rostral"),
  col = c("#47479fff", "lightcoral", "#227a22ff"),
  pch = 19,
  bty = "n"
)


# Proc. ANOVA ----
fit <- procD.lm(
  landmarks.gpaTilt$coords ~
    orientation + specimen,
  data = Tilt_df,
  iter = 999
)

summary(fit)

## Proc. pairwise ----
idx <- Tilt_df$orientation %in% c("caudal", "ref")

fit_ca_ref <- procD.lm(
  landmarks.gpaTilt$coords[, , idx] ~ orientation + specimen,
  data = droplevels(Tilt_df[idx, ]),
  iter = 999
)

summary(fit_ca_ref)

idx <- Tilt_df$orientation %in% c("rostral", "ref")

fit_ro_ref <- procD.lm(
  landmarks.gpaTilt$coords[, , idx] ~ orientation + specimen,
  data = droplevels(Tilt_df[idx, ]),
  iter = 999
)

summary(fit_ro_ref)

idx <- Tilt_df$orientation %in% c("caudal", "rostral")

fit_ca_ro <- procD.lm(
  landmarks.gpaTilt$coords[, , idx] ~ orientation + specimen,
  data = droplevels(Tilt_df[idx, ]),
  iter = 999
)

summary(fit_ca_ro)

# mean shape ----
coords <- landmarks.gpaTilt$coords

idx_caudal  <- which(Tilt_df$orientation == "caudal")
idx_ref     <- which(Tilt_df$orientation == "ref")
idx_rostral <- which(Tilt_df$orientation == "rostral")


mshape_caudal  <- mshape(coords[, , idx_caudal])
mshape_ref     <- mshape(coords[, , idx_ref])
mshape_rostral <- mshape(coords[, , idx_rostral])


plot(mshape_caudal)

plot(mshape_ref)

plot(mshape_rostral)
