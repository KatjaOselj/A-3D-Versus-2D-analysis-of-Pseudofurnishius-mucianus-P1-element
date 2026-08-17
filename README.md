# 3D Versus 2D analysis of *Pseudofurnishius murcianus*

Code and data supporting the manuscript "Quantifying Conodont Shape: Comparing 2D and 3D Morphometric Approaches in *Pseudofurnishius murcianus*"

## Authors

Katja Oselj
katja.oselj@geo-zs.si
(maintainer)

Emilia Jarochowska 
e.b.jarochowska@uu.nl

Luka Gale 
luka.gale@geo-zs.si
luka.gale@ntf.uni-lj.si

Tea Kolar-Jurkovšek 
tea.kolar-jurkovsek@geo-zs.si

Bogdan Jurkovšek
geolog.bj@gmail.com

Vogel Hannah
h.p.vogel@uu.nl

Amiri Hamed
h.amiri@uu.nl

Plümper Oliver
o.plumper@uu.nl

Carlos Martínez-Pérez 
carlos.martinez-perez@bristol.ac.uk
carlos.martinez-perez@uv.es



## Repository structure

```
P.murcianus_geometric_morphometrics/
├── INPUT/
│   ├── 2D.TPS          # Raw landmark coordinates for 2D dataset (TPS format)
│   ├── 3Dall.TPS       # Raw landmark coordinates for 3Dall dataset (TPS format)
│   ├── 3Dsimp.TPS      # Raw landmark coordinates for 3Dsimp dataset (TPS format)
│   └── 2D_VS_3D.R      # Read TPS file, run GPA and PCA, Statistical analyses (Procrustes permutation test)
├── OUTPUT/
│   ├── Exploratory Data Analysis/     # Output figures (Length distribution_boxplot, Length distribution_hist, PC1 distribution_boxplot, PC1 distribution_hist)
│   └──  Shape/
│        ├── Extreme_values_3Dall/     # Figures of shapes of extreme values 3Dall dataset
│        ├── Extreme_values_3Dsimp/    # Figures of shapes of extreme values 3Dsimp dataset
│        ├── Mean_shape_3Dall/         # Figures of mean shpe of elements in 3Dall dataset 
│        ├── Mean_shape_3Dsimp/        # Figures of mean shpe of elements in 3Dsimp dataset
│        ├── Extreme_values_2D         # Figure of shapes of extreme values 2D dataset
│        └──  Mean_shape_2D            # Figure of mean shpe of elements in 2D dataset
├── Figs/               # Figures used in MS (Fig.1-3)
├── curveslide.csv      # information about sliding semilandmarks
└── 2D_VS_3D.Rproj
```

## Software requirements

R (≥ 4.1.0) with the following packages:

| Package | Purpose |
|---------|---------|
| `geomorph` | Landmark import, GPA, PCA, morphometric analyses |
| `vegan` | Multivariate community-ecology statistics |
| `car` | Levene's test for variance homogeneity |
| `ggplot2` | Plotting |
| `ggfortify` | Plotting |
| `rgl` | Interactive 3D graphics |
| `dplyr` | Data manipulation |
| `plot3D` | 3D plotting |
| `knitr` | R Markdown rendering |

Install all packages at once:

```r
install.packages(c(
  "geomorph", "vegan", "car", "ggplot2", 
  "ggfortify", "rgl", "dplyr", "plot3D", 
  "knitr"
))
```

## Running instructions

Open `2D_VS_3D.Rproj` in RStudio (or set the project root as the working directory), then run the scripts in the following order:

1. **Import and process data**
   ```r
   source("INPUT/2D_VS_3D.R")   # reads All_sections.TPS, runs GPA + PCA and Procrustes permutation test

   ```


## License 

Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

## Copyright

Copyright 2026 the Geological Survey of Slovenia, Ljubljana University, Utrecht University, Instituto de Ciências da Terra, University of Bristol and University of Valencia

## Funding

KO was founded by Slovenian Research and Innovation Agency (research core funding No. P1-0011), CMP by the Ministry of Science and Innovation of Spain (Research Project PID2020-117373GA-I00), EJ was funded by the European Union (ERC, MindTheGap, StG project no 101041077). This project has received funding from the European Union’s Horizon Europe research and innovation programme under grant agreement no. 101131765 (EXCITE2) for Transnational Access conducted at EM Centre at Utrecht University. Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Commission. Neither the European Union nor the granting authority can be held responsible for them.


