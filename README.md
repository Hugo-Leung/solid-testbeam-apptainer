SOLID-testbeam 2026 container
=============


Prerequisite
------------
I am using [apptainer](https://apptainer.org). So it have to be installed first 

Building the image
---------
```
apptainer build testbeam.sif testbeam.def
```

Using the container
--------
To get a shell
```
apptainer shell testbeam.sif
```
We need to specify the location of the evio files, root files and the log file
```
apptainer shell -B <Path to data>:/opt/data,<Path to root files>:/opt/Rootfiles,<Path to log files>:/opt/logs testbeam.sif 
```
This can also be specify in `APPTAINER_BINDPATH` environment variable, such as
```
export APPTAINER_BINDPATH=<Path to data>:/opt/data,<Path to root files>:/opt/Rootfiles,<Path to log files>:/opt/logs
```

To excute a command in the container
```
apptainer exec testbeam.sif <command>
```

The replays are placed in `\opt\SBS-replay_SOLIDtestbeam`

To directly execue analyzer and run a replay
```
apptainer run testbeam.sif <replay script>
```

Using custom replay
------------------
To overwrite the built-in replay, bind the path to your replay to `\opt\SBS-replay_SOLIDtestbeam`
```
apptainer shell -B <Path to replay on host>:\opt\SBS-replay_SOLIDtestbeam testbeam.sif 
```



