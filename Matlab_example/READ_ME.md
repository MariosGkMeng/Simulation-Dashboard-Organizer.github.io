This is a working example for MATLAB (Mode 1, in case your SIMULATOR is MATLAB). 
The system simulated here is a system of two 1st order nonlinear differential system with two variables.

Open the "Sim_Dashboard.xlsm", which is the developed tool. From there you can change system parameters, run simulations, store results, compare results etc (refer to "READ_ME" in the main folder)


You will have to add the parameters in the excel tool from scratch. You can use the following as a starting point (order does not matter). 

c0 = 0.1335;
c1 = 2;
c2 = 4;
c3 = 2.3;
c4 = 6;
c5 = 1;
c6 = 2;
A0 = 0;
P0 = 0;
dp = 0.2;
da = 0.1;
dt = 0.1;
t_end = 25;
md_sol_track = "...\Matlab example\solution_tracker.txt";

The "runs_sim.m" script is the one that performs the calculations, i.e. the simulation. 
