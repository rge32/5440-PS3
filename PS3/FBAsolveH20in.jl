using CSV
using LinearAlgebra

##Load Stoichiometrix Matrix

SData=CSV.read(".\\stoichiometricratios.csv")
S=convert(Array{Float64}, Matrix(SData))

## Load c vector (maximization function)
CData=CSV.read(".\\cvector.csv")
C=convert(Array{Float64},[0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0])

##Load [Lv, Uv]
lvuvData=CSV.read(".\\lvuvOnlyH20in.csv")
lvuv=convert(Array{Float64},transpose(Matrix(lvuvData)))

##Load [Lx, Ux]
lxuxData=CSV.read(".\\lxux.csv")
lxux=convert(Array{Float64},transpose(Matrix(lxuxData)))


##Solving the FBA
include("Flux.jl")

calculate_optimal_flux_distribution(S,lvuv,lxux,C;min_flag=true)
