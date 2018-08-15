% Parallel MATLAB workshop: Savio-specific notes
% August 15, 2018
% Chris Paciorek


# Outline

Berkeley Research IT helps researchers through its Berkeley Research Computing (BRC) and Research Data Management (RDM) programs. 

This document contains information on:

 - Savio campus cluster
     - Getting access to the system - faculty computing allowance, condo
     - Savio computing nodes
     - Cluster job submission/scheduling
     - MATLAB usage on Savio
 - Disk storage at Berkeley
     - Where can I put my stuff
     - Data transfer
 - How to get help


# System capabilities and hardware

Berkeley Research Computing runs the campus cluster, Savio.

  - Savio is a >380-node, >8000-core, >169000-gpu-core Linux cluster rated at >350 peak teraFLOPS. 
     - about 174 compute nodes provided by the UC Berkeley for general access
     - about 211 compute nodes contributed by researchers in the Condo program


# Getting access to the system - FCA and condo

- All regular Berkeley faculty can request 300,000 service units (roughly core-hours) per year through the [Faculty Computing Allowance (FCA)](http://research-it.berkeley.edu/services/high-performance-computing/faculty-computing-allowance)
- Researchers can also purchase nodes for their own priority access and gain access to the shared Savio infrastructure and to the ability to *burst* to additional nodes through the [condo cluster program](http://research-it.berkeley.edu/services/high-performance-computing/condo-cluster-program)
- Instructors can request an [Instructional Computing Allowance (ICA)](http://research-it.berkeley.edu/programs/berkeley-research-computing/instructional-computing-allowance). 

Faculty/principal investigators can allow researchers working with them to get user accounts with access to the FCA or condo resources available to the faculty member.

# Savio computing nodes

[Savio](https://research-it.berkeley.edu/services/high-performance-computing) provides access to the following types of computational resources:

 - full 20/24/28 core nodes scheduled per-node
 - 'htc' nodes scheduled per-core
 - GPU nodes (scheduled per GPU)
 - big-memory nodes (scheduled per node)
 - Jupyter notebooks
 - a visualization/remote desktop node
 
Let's take a look at the hardware specifications of the computing nodes on the cluster [(see the *Hardware Configuration* section of this document)](https://research-it.berkeley.edu/services/high-performance-computing/user-guide/savio-user-guide).

The nodes are divided into several pools, called partitions. These partitions have different restrictions and costs associated with them [(see the *Scheduler Configuration* section of this document)](https://research-it.berkeley.edu/services/high-performance-computing/user-guide/savio-user-guide). Any job you submit must be submitted to a partition to which you have access.

# Submitting jobs: accounts and partitions

All computations are done by submitting jobs to the scheduling software that manages jobs on the cluster, called SLURM.

 - interactive jobs (via srun)
 - interactive jobs (with faster visualization capabilities via [Savio viz node](http://research-it.berkeley.edu/services/high-performance-computing/using-brc-visualization-node-realvnc)) 
 - batch/background jobs (via sbatch)

Here's an example job script for a batch job. You'll need to modify the various "--" flags for your own work.

```
#!/bin/bash
# Job name:
#SBATCH --job-name=test
#
# Account:
#SBATCH --account=fc_paciorek
#
# Partition:
#SBATCH --partition=savio2
#
# Number of tasks
#SBATCH --ntasks=1
#
# Number of cores per task
#SBATCH --cpus-per-task=24
#
# Wall clock limit (30 minutes here):
#SBATCH --time=00:30:00
#
## Command(s) to run:
module load matlab
matlab < run.m > output.txt
```

Note that you'll be charged for a full node (except in the savio2_htc and savio2_gpu partitions), so ideally your MATLAB code should make use of the 24 cores on Savio2 node in this case.

# Using MATLAB on Savio

You need to show that you have a MATLAB license in order to use MATLAB on Savio.

For more details on showing you have a license and using MATLAB on Savio, see [here](http://research-it.berkeley.edu/services/high-performance-computing/using-matlab-savio).

One key difference from using MATLAB on your laptop is that you need to make sure that the number of cores you request from SLURM in your job script aligns with the number of cores that MATLAB will use.


# Using MATLAB DCS on Savio

MATLAB DCS allows one to use computational resources across multiple nodes. You can use up to 32 workers (based on our current DCS license) and one or more cores per worker. (Note that the 32 workers are shared across all Savio users at any given time.)

Details are [here](http://research-it.berkeley.edu/services/high-performance-computing/using-matlab-savio/running-matlab-jobs-across-multiple-savio).

Key items to remember:

  - run `configCluster` in MATLAB once in your account
  - request as many MATLAB licenses as MATLAB workers you will use, e.g.,
      - `#SBATCH --licenses=mdcs:28`
  - in each MATLAB DCS cluster job, do:
      - `module load matlab`
      - `export MDCE_OVERRIDE_EXTERNAL_HOSTNAME=$(/bin/hostname -f)`
  - use the "savio" MATLAB parallel cluster profile

Please see the [example sbatch submission script](matlab_sbatch_template.sh) and [example MATLAB parallel script](example_parpool.m).

# Disk space options on Savio and on campus broadly

Here are some options for moderate-large disk storage options:

 - Savio project storage: 200 GB, backed up
 - Savio scratch: 1.5 PB shared across all users, not backed up, subject to removal
 - Savio condo (purchase) storage: roughly $6000 per 42 TB
 - Berkeley Box: unlimited, 15 GB file size limit
 - bDrive (Berkeley Google drive): unlimited
 

More details on Savio storage are here [here in the *Storage and Backup* section](https://research-it.berkeley.edu/services/high-performance-computing/user-guide/savio-user-guide).



# Data transfer for large data

Some options include:

 - [Globus](https://research-it.berkeley.edu/services/high-performance-computing/using-globus-connect-savio) (to/from Savio, laptop, XSEDE)
 - [rclone](https://research-it.berkeley.edu/services/research-data-management-service/take-advantage-unlimited-bdrive-storage-using-rclone) (to/from bDrive and Berkeley Box)

# How to get additional help

 - For technical issues and questions about using Savio: 
    - brc-hpc-help@berkeley.edu
 - For questions about computing resources in general, including cloud computing: 
    - brc@berkeley.edu or research-it-consulting@berkeley.edu
 - For questions about data management (including HIPAA-protected data): 
    - researchdata@berkeley.edu or research-it-consulting@berkeley.edu
 - Office hours for any of the above topics:
     - Tues. 10-12, Wed. 1:30-3, Thur. 9:30-11:30 in AIS (Dwinelle 117)

Don't hesitate to contact us; we're friendly, even with basic questions.

# Upcoming events
 
 - Savio intro workshop Thursday September 17
 - Other trainings planned for the fall
