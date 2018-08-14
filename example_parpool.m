% note that you should have run 'configCluster' once in MATLAB in your account at some point before attempting the code below

c = parcluster('savio');
mps = maxPoolSize(); % this will equal the number of SLURM tasks
% MATLAB recommends one fewer worker than the number of cores available, but your job also may work with a single core being shared by the master process and a worker
p = c.parpool(mps-1);
parfor ...
...

p.delete;