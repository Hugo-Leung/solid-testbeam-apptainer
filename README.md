SOLID-testbeam 2026 container
=============


Prerequisite
------------
I am using [apptainer](https://apptainer.org). So it have to be installed first 

Building the image
---------
The container image is split into two part, `base` contains ROOT and other system libraries; and `testbeam` will add the analyzer and the replays. This is done because compiling root from source can take a long time. 

A script is provided to compile the two images. To build the first base image.
```
./build-container.sh -b
```

To add analyser and replays.
```
./build-container.sh -r
```


To build everything
```
./build-container.sh -a 
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
This can also be specified in the `APPTAINER_BINDPATH` environment variable, such as
```
export APPTAINER_BINDPATH=<Path to data>:/opt/data,<Path to root files>:/opt/Rootfiles,<Path to log files>:/opt/logs
```
This can be added to .bash_profile and these paths will be binded every time.

To excute a command in the container
```
apptainer exec testbeam.sif <command>
```

Installed software
-------------------
* Hall A analyzer (https://github.com/JeffersonLab/analyzer)

Analyzer is set as the default command and will be excuted by
```
apptainer run testbeam.sif 
```

* Panguin (https://github.com/JeffersonLab/panguin)
```
apptainer exec testbeam.sif panguin 
```

* SBS-offline_SOLIDtestbeam (https://github.com/JeffersonLab/SBS-offline_SOLIDtestbeam)

This is installed in `/opt/SBS-offline_SOLIDtestbeam`

* SBS-replay_SOLIDtestbeam (https://github.com/JeffersonLab/SBS-replay_SOLIDtestbeam)

The replays are placed in `\opt\SBS-replay_SOLIDtestbeam`. To directly execue analyzer and run a replay
```
apptainer run testbeam.sif <replay script>
```

Using custom replay
------------------
To overwrite the built-in replay, bind the path to your replay to `\opt\SBS-replay_SOLIDtestbeam`
```
apptainer shell -B <Path to replay on host>:\opt\SBS-replay_SOLIDtestbeam testbeam.sif 
```



