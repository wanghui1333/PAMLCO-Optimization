# Single Well Optimization Tool
## Overview
This single-well optimization tool represents a component of the PAMLCO framework, designed to efficiently optimize shale gas well completion parameters. The tool employs a dual-approach strategy combining Gaussian Process Regression (GPR) proxy modeling with Genetic Algorithm (GA) to achieve optimal well designs while dramatically reducing computational time.
## Key Features
- Optimizes four critical completion parameters:
- Cluster Spacing (CS)
- Fracture Half-Length (FHL)
- Horizontal Section Length (HSL)
- Fracture Conductivity (FC)
- Implements a hybrid approach using:
- GPR-based proxy model for rapid evaluation
- Genetic Algorithm (GA) for robust optimization
- Numerical simulation validation
- Provides comprehensive performance assessment:
- Net Present Value (NPV) calculation
## Validation Performance
- Achieves parameter optimization results comparable to full numerical simulation
- Demonstrates excellent agreement in pressure distribution predictions
- Delivers substantial economic improvements (>$4.3 million NPV increase)
- Reduces computational time by 2400× compared to conventional methods
- Converges consistently over 50 iterations
## Version
Single Well Optimization Tool v1.0.0



# Fracture Proxy Model
﻿
## Overview
This Fracture Proxy Model represents an innovative machine learning-enhanced approach for predicting hydraulic fracture properties based on completion design parameters. The model employs Gaussian Process Regression (GPR) to establish robust relationships between completion inputs and resulting fracture characteristics, eliminating the need for computationally intensive numerical simulations during optimization.
﻿
## Key Features
- Predicts critical fracture properties:
- Fracture Half-Length (FHL)
- Fracture Conductivity (FC)
- Incorporates completion parameters:
- Fracturing fluid volume per section
- Proppant amount per section
- Number of fracturing sections
﻿
## Technical Implementation
- Developed using systematic experimental design:
- 324 initial scenarios (54 fluid volume levels × 6 proppant concentration levels)
- 313 physically valid cases after filtering
- Calibrated to site-specific geotechnical parameters
- Integrates with completion cost model for economic assessment
- Serves as objective function component in PAMLCO optimization framework
﻿
## Applications
- Rapid evaluation of completion scenarios
- Sensitivity analysis of completion parameters
- Integration with economic models for NPV calculation
- Support for field development strategy optimization
﻿
## Model Inputs
- Fracturing fluid volume
- Proppant amount/concentration
- Geotechnical parameters 
﻿
## Model Outputs
- Fracture Half-Length (m)
- Fracture Conductivity (md·m)
- Associated completion costs
﻿
## Version
Fracture Proxy Model v1.0.0

# PAMLCO Framework

## Overview
The Proxy-Assisted Multi-Layer Cooperative Optimization (PAMLCO) framework is a comprehensive computational solution for field-scale shale gas development optimization. This framework addresses the computational challenges inherent in high-dimensional optimization problems while maintaining solution accuracy through a hierarchical approach.

## Architecture
The PAMLCO framework consists of three interconnected modules:

1. **Geological Characterization Module**:
   - Integrates multi-scale geological data (core analysis, well logging, 3D seismic interpretation)
   - Generates high-resolution distribution maps of key reservoir parameters
   - Outputs spatial distributions of porosity, gas saturation, reservoir pressure
   - Maps surface constraints including structural depth and ground elevation

2. **Production-Economic Coupling Module**:
   - Implements a hybrid approach combining machine learning and numerical simulation
   - Establishes robust relationships between well design parameters and production performance
   - Integrates with the geological characterization outputs
   - Provides economic assessment of development strategies

3. **Multi-Layer Optimization Module**:
   - Decomposes high-dimensional field optimization into three hierarchically connected subproblems
   - Outer layer: Generates estimates for global parameters
   - Middle layer: Performs well-group optimization considering geological heterogeneity and surface constraints
   - Inner layer: Executes detailed single-well optimization using exhaustive search algorithm with GPR proxy model
   - Implements bidirectional information flow with results propagating upward through the hierarchy

## Key Features
- Hierarchical optimization approach
- Integrated geological-production-economic analysis
- Machine learning proxy models for rapid assessment
- Iterative refinement until convergence criteria are met
- Computationally efficient solution for high-dimensional problems

## License
This software is released under [LICENSE TYPE] license. See the LICENSE file for details.

## Version
PAMLCO Framework v1.0.0
