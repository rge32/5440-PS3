# Problem Set 3
## Part A
For this part I used KEGG to find the human pathway for the given collection of reactions. Including the chemical species given in Fig. 1 as well as the other reactants and products for the 5 reactions. The coefficients in the matrix correspond to the stoichiometry of the species in that reaction. Since reaction 5 is reversible, I split the forward and reverse in the matrix. Exchange reactions were included for the 4 specified species in addition to the other reactants and products of the reactions, with water being allowed to exchange into and out of the system. The final resulting matrix is found in the file stoichimetricratios.xlsx with column and row headings and without in the.csv version.

## Part B
I used the reactions in KEGG to determine the molecular formula of all of the metabolites in the process and compiled them in the atommatrix.csv  with rows of metabolites, in the same order as in the stoichiometrix matrix, and columns of atoms. I then ran the code in AtomBalances.jl which multiples Atranspose*S. The result is a matrix with all zeros in the first 6 columns which confirms that our reconstruction of the cycle is balanced by elements.

## Part C
To solve part C we have to use FBA and run the function calculate_optimal_flux_distribution in Flux.jl. In order to do that I needed S, [Lv,Uv], [Lx, Ux], and c. I also neglected dilution due to growth.

* We found S in part A.
* c is the objective vector so it is a vector of all zeros exept in the position corresponding to b4 urea flux out of the system. This value is -1 as the solver will minimize this function.
* The [Lx,Ux] matrix is given in lxux.csv. All the values are zero since we are at steady state.
* [Lv, Uv] is the upper and lower bounds on the fluxes given in lvuv.csv. Since all reversible reactions are split the lower bound for all fluxes is ). The upper bound for all the exchange fluxes is set to 10 mmol/gDW-hr as given in the problem. The bounds for the reactions are set by the formula vj<=Vmax(ej/ej0)theta*Fj(metabolites). Where Fj is a hill function from michaelis-menton kinetics if the data exist for the reaction, if not this is set to 1. Theta is set 1. The data given in the problem set are entered for Vmax and Enzyme concentration, and converted to the units of mmol/gDW-hr to calculate the upper bounds.

This information is all imported into Julia and the FBA evaluated in the function FBAsolve.jl

The result of this code gives a value of -1.242. Which means the calculated max flux of Urea out of the system is 1.242 mmol/gDW-hr.

## Other cases
I also explored the case by not allowing water to exchange by setting the maximum value of the flux in an out to zero, and repeating the calculation by running FBAsolveNoH20.jl. This leads to a different maximum value for urea of 0.828 mmol/gDW. The same value of 1.242 mmol/gDW can be recovered by allowing water in and not water out, this is shown by running FBAsolveH20in.jl

Although we only accounted for metabolite concentration in the upper bound of v1 and v4. I also explored the impact of not including them and using the upper bound of Vmaz*E for all of the reactions, in FBAsolveNoMetabolites.jl. This results as the same maximum value of 1.242 mmol/gDW-hr as before. This makes sense as this is the maximum value v2 can take (the lowest among v1-v4), and that does not change when changing the upper bound when increasing v1 and v4.
