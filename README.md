# TL;DR

For advanced users
- Campus network is **REQUIRED**, if outside campus, use VPN
- Torque PBS: The job queue
- Environment-modules: Used to load (probably) everything else you need
- Anaconda3: Recommended for both python and non-python users
- Intel compiler: Version 2015 (Cluster licensed) / 2018 (BYOL) / 2019 (Highly NOT recommended)
- [FAQ](https://github.com/kftsehk/phy-clusters/wiki/FAQ)
- [Wiki Pages](https://github.com/kftsehk/phy-clusters/wiki)
- Your contribution: _Highly welcomed and valued_

# Problem reporting

To report a problem of any cluster, or suggest an improvement

- Open a new issue in the [Issues tab](https://github.com/kftsehk/phy-clusters/issues)
- Tag the appropriate cluster: `cluster1` `cluster2` `cluster3`

For problem report:
- Briefly describe the problem
- Attach your job script, `.e[jobid] .o[jobid]` file if available

Account request should go through private email, do not open an issue to request for cluster access

# Tutorial

If you do not already have a preference of terminal, we recommend 

- Windows: [MobaXterm](https://mobaxterm.mobatek.net/), a free SSH client that supports running GUI application on remote machine (X11 forwarding)
- Mac: Built-in Terminal app, install [XQuartz](https://www.xquartz.org/) for X11 forwarding
- Linux: `ssh`, `ssh -X` to enable X11 forwarding

You will be using Linux, if you are new to Linux, [this linux command cheatsheet](https://github.com/kftsehk/phy-clusters/wiki/Linux-commands) shows how to do some common operations, you will need these commands everyday.

### Signing In
1. ssh cluster and login with your username and password
2. Change your password with "yppasswd"
```
[kftse@mu01 ~]$ yppasswd
Changing NIS account information for kftse on mu01.
Please enter old password:
Changing NIS password for kftse on mu01.
Please enter new password:
Please retype new password:
The NIS password has been changed on mu01.
```

### Compiling your code
3. Compile your code with icc (Intel C Compiler)
```
[kftse@mu01 ~]$ module avail
# ...
----------------------------------------------------- /opt/modulefiles ------------------------------------------------------
anaconda2                          gmp-6.1.2                          parallel_studio_xe_2015
anaconda3                          gnu-utils-latest                   parallel_studio_xe_2018
# ...
[kftse@mu01 ~]$ module load parallel_studio_xe_2015
[kftse@mu01 ~]$ which icc
/opt/intel/composer_xe_2015.1.133/bin/intel64/icc
[kftse@mu01 ~]$ ls
test.c
[kftse@mu01 ~]$ icc test.c -o test.out
[kftse@mu01 ~]$ ls
intel  test.c  test.out
```
4. Test run your code at to eliminate obvious errors before submitting
```
[kftse@mu01 ~]$ ./test.out
Hello world!
```

### Submitting jobs
5. Prepare the submit script as shown below (submit.sh)
```
[kftse@mu01 ~]$ ls
submit.sh  test.c  test.out
[kftse@mu01 ~]$ cat submit.sh
#!/bin/bash
#
### The shell you want to use
#PBS -S /bin/bash
### The competition queue
### Max resources: 1 node, 24 core, 30 min of running time
#PBS -q debug

cd $PBS_O_WORKDIR

./test.out  ## You may want to pipe this to another file.
```
6. Submit the job with `qsub`
```
[kftse@mu01 ~]$ qsub submit.sh
3715.mu01
[kftse@mu01 ~]$ qstat
Job id                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
3715.mu01                  submit.sh     kftse                0 Q debug
```
7. Wait for result

The status is Queuing, Running, Completed and Exiting
When completed, you will receive `submit.sh.o[jobid]` and `submit.sh.e[jobid]` for the `stdout` and `stderr` of your program
```
[kftse@mu01 ~]$ qstat
Job id                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
3715.mu01                  submit.sh     kftse                0 R debug
[kftse@mu01 ~]$ qstat
Job id                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
3715.mu01                  submit.sh     kftse                0 C debug
[kftse@mu01 ~]$ ls
submit.sh  submit.sh.e3715  submit.sh.o3715  test.c  test.out
```
8. Use `qdel` to delete a wrongly submitted job

If you delete a Running job, you will still receive .o and .e file containing output generated before the job is deleted.
```
[kftse@mu01 ~]$ qstat
Job id                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
3715.mu01                  submit.sh     kftse                0 Q debug
[kftse@mu01 ~]$ qdel 3715
[kftse@mu01 ~]$ qstat
Job id                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
3715.mu01                  submit.sh     kftse                0 C debug
```

# Advanced Use Cases

### Submitting Many Similar Jobs
Example Uses:
- Submit many jobs of the same program, different parameters
- Submit the same script, running in different folder named sequentially

Modify your script to run differently depends on the env parameter `$PBS_ARRAYID` and submit with `qsub -t 1-N`

Note:
- 10 idle job rule still applies, and each sub-job within an array job count as ONE job

[Documentation](http://docs.adaptivecomputing.com/torque/4-1-4/help.htm#topics/2-jobs/multiJobSubmission.htm)

### Using SSL and Git

We recommend you to `conda activate` and use internet access within this environment to work around issues such as
- Outdated SSL certificate
- Too old version of git

# Resource Overview

## Computing Resources

Note:
- 1 Point of computing capability ~ Practically 16-20 GFlops
- Nodes are shared among queues

### cluster1

16 Core, Compute capability per node ~ 16

Queue | Memory | Time Limit | Max # nodes 
---|---|---|---
debug | 32G | 30m | 2
normal | 32G | 2d | 42
bigmem | 64G | 2d | 7
long | 32G | 7d | 4


### cluster2

24 Core, Compute capability per node ~ 48

Queue | Memory | Time Limit | Max # nodes
---|---|---|---
debug | 128G | 30m | 2
normal | 128G | 2d11h59m | 44
bigmem | 256G | 2d11h59m | 9
long | 128G | 4d23h59m | 10

Remark:
- Whole cluster reserved on every Sun 0:0:0 - Mon 23:59:59 for Prof. HB Li's group
- Submit job on _mu01_

### cluster3

28 Core, Compute capability ~ 56

Queue | Memory | Time Limit | Max # nodes
---|---|---|---
debug | 256G | 30m | 2
normal | 256G | 2d11h59m | 12
bigmem | 512G | 2d11h59m | 4
long | 256G | 7d | 12

Remark:
- Submit job on _head_

## Queue Policy
- 1 minute = 1 priority point
- Max. 10 jobs from each user receive priority point
- Queue priority: a) bigmem + 2880, b) long - 2880
- User and group priority will be adjusted according to last 14-day usage, i.e. high usage users and groups will have a lower initial priority
- Reservation can be requested in advance
- Paying research groups has higher priority (not listed here)
