using CSV
using LinearAlgebra

SData=CSV.read(".\\stoichiometricratios.csv")
S=Matrix(SData)
AData=CSV.read(".\\atommatrix.csv")
A=Matrix(AData)

E=transpose(A)*S
