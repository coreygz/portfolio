---
layout: default
title: Mathematics Projects
permalink: /math/
---

# Mathematics Projects
<!--
This text is a comment and won’t show up
when GitHub Pages renders the page.

A showcase of my mathematical modeling and computational methods.  

## Study

Explore theory, lecture notes, and algorithms in numerical methods and parallel computing:  
- [Scientific Computing Deep Dive →](/math/scientific-computing/)
-->
<br><br>

## Projects

1. **Blackjack Optimal Strategy**  
   **Description:** Developed a full decision‐analysis model for blackjack by constructing Markov‐chain transition matrices for each player hand (hard, soft, and pairs) against every dealer up-card. Computed expected values (EV) for hit/stand/double/split actions using conditional probability, and implemented a dynamic programming algorithm to derive the optimal strategy.  
   **Tools/Techniques:** Python (NumPy, Pandas, Matplotlib), dynamic programming, conditional probability, Markov chain modeling.  

   - [Report (PDF)](../assets/docs/BJPROJECT2.pdf)  
   - [Worksheets (Excel)](../assets/docs/math_model_disc/BJPROJECT.xlsx)
   - [Markov Chain Code (Mathematica)](../assets/docs/math_model_disc/bjproject.nb)


2. **Lotka-Volterra Competition**  
   **Description:** Formulated and analyzed the classical two-species competition model under shared resource limitation.  Starting from logistic growth, I derived the coupled ODEs, performed nondimensionalization to minimize parameters, identified nullclines and equilibrium points, and conducted stability and phase-plane analyses to explore coexistence versus exclusion regimes.  
   **Tools/Techniques:** Mathematica for symbolic derivations and phase-portrait plotting; Python (SciPy, Matplotlib) and MATLAB for numerical simulations and visualization.  
   - [Report (PDF)](../assets/docs/math_model_cont/Competition_Model.pdf)
   - [Presentation(PowerPoint)](../assets/docs/math_model_cont/Lotka-Volterra%20Competition.pptx)
   - [Code (Python)](../assets/docs/math_model_cont/lotka_volterra_code.py)
     

3. **Luo-Rudy Cardiac Cell Model**  
   **Description:**  Used the Luo–Rudy model to explore how heart cells create and pass along electrical signals. I treated the cell membrane like an electric circuit with a capacitor and gates that open for ions, then wrote linked equations to track voltage and gate changes over time. Next, I built a line of connected cells to see how the signal travels down the fiber. I ran simulations that step through time for each cell and across space for the fiber to follow the wave. Finally, I tested how different potassium levels outside the cells and the strength of connections between cells affect the shape and speed of the electrical wave.   
  **Tools/Techniques:** MATLAB (ODE/PDE solver & visualization), PowerPoint
   - [Final Report (PDF)](../assets/docs/practicum_cont/MAT%20555%20Luo-Rudy%20Final.pdf)
   - [Presentation(PowerPoint)](../assets/docs/practicum_cont/Luo%20Rudy%20Prez(Corey).pptx)
   - [ODE Code (MATLAB)](../assets/docs/practicum_cont/luo%20rudy%20ode.m)  
   - [PDE Code (MATLAB)](../assets/docs/practicum_cont/luo%20rudy%20pde.m)
   

4. **Magic Square Construction via Operations Research**   
**Description:** Modeled the *n×n* magic square as a combinatorial optimization problem by assigning each cell xᵢⱼ an integer decision variable and enforcing row, column, and diagonal sum constraints, along with all-different conditions. Used a CP-SAT integer-programming solver to generate classical Lo-Shu (3×3) magic squares and extended the framework to construct orthogonal Latin squares for error-correcting codes.  
**Tools/Techniques:** Excel, integer programming, combinatorial optimization.  

   - [Solver Report (PDF)](../assets/docs/op_research/Magic_Square.pdf)  
  
