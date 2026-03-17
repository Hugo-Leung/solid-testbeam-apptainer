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
on ifarm, you might also want to bind `/w` and `/cache` so we can access those directories for analysis, so you might want to add the following flags
```
apptainer shell -B /w,/cache testbeam.sif
```

To excute a command in the container
```
apptainer exec -B /w,/cache testbeam.sif <command>
```

The replays are placed in `\opt\SBS-replay_SOLIDtestbeam`

To directly execue analyzer and run a replay
```
apptainer run testbeam.sif <replay script>
```

