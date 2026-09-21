# 3D Versus 2D analysis of *Pseudofurnishius murcianus*

This repository contains the code and 3D models associated with the manuscript “Quantifying Conodont Shape: Comparing 2D and 3D Geometric Morphometrics”, resulting from the EXCITE Conomorph-3D project (E2_C1_75_Oselj).

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
HVogel@ucc.ie

Amiri Hamed
h.amiri@uu.nl

Plümper Oliver
pluemper@uni-bremen.de

Carlos Martínez-Pérez 
carlos.martinez-perez@bristol.ac.uk
carlos.martinez-perez@uv.es



## Repository structure

```
A-3D-Versus-2D-analysis-of-Pseudofurnishius-mucianus-P1-element/
├── README.md
├── Code/
│   ├── INPUT/
│       ├── 2D.TPS          # Raw landmark coordinates for 2D dataset (TPS format)
│       ├── 3Dall.TPS       # Raw landmark coordinates for 3Dall dataset (TPS format)
│       ├── 3Dsimp.TPS      # Raw landmark coordinates for 3Dsimp dataset (TPS format)
│       └── 2D_VS_3D.R      # Read TPS file, run GPA and PCA, Statistical analyses (Procrustes permutation test)
 dataset
│   ├── Figs/               # Figures used in MS (Fig.1-3)
│   ├── curveslide.csv      # information about sliding semilandmarks
│   ├── 2D_VS_3D.Rproj
│   └──  README.md          # README for R code
├── 3Dmodels/
    ├── Bu-I-26-37.ply
    ├── Bu-I-26-81.ply
    ├── ...
    ├── PR24-19.ply
    ├── model_metadata.xlsx
    └──  README.md          # README for 3D models

```


## License

### Code

Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   
### 3D models and metadata

The 3D models and associated metadata are made available under the
Creative Commons Attribution 4.0 International (CC BY 4.0) License.


## Copyright

Copyright 2026 the Geological Survey of Slovenia, Ljubljana University, Utrecht University, Instituto de Ciências da Terra, University of Bristol and University of Valencia

## Funding

KO was founded by Slovenian Research and Innovation Agency (research core funding No. P1-0011), CMP by the Ministry of Science and Innovation of Spain (Research Project PID2020-117373GA-I00), EJ was funded by the European Union (ERC, MindTheGap, StG project no 101041077). This project has received funding from the European Union’s Horizon Europe research and innovation programme under grant agreement no. 101131765 (EXCITE2) for Transnational Access conducted at EM Centre at Utrecht University. Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Commission. Neither the European Union nor the granting authority can be held responsible for them.


