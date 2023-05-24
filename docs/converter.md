# GNSS converter

If you own an GNSS receiver with its custom format you are probably wondering how to
convert it into rinex file 

First of all login to the service and head towards the **GNSS converter** 
(at the top of the page). You should see the following page:

![GNSS converter for Argonaut data](images/howto_conversor.png "GNSS converter for GNSS data")

Simply drag and drop the file you want to process in the `Raw file`
box and press convert. Once the process is finished, press `Download zip` to 
fetch the data. Assuming that the you uploaded a file named `<input_file>`, you
should see the following files:

- `<input_file>.rnx`: The Rinex file (version 3.03) with the GNSS raw measurements recorded by the receiver

## Converted files

This section includes a description of the files delivered by the GNSS converter

### Argonaut GNSS file

GNSS receivers store GNSS data in multiple formats (UBLOX, SBF, GnssLogger). The output of the GNSS converter in terms of GNSS measurements data will be the equivalent RINEX 3.03 file as follows:

```txt
     3.03           OBSERVATION DATA    M (MIXED)           RINEX VERSION / TYPE
Rokubun core        rokubun             2019-08-12 15:43:35 PGM / RUN BY / DATE
UNKN                                                        MARKER NAME
unknown             unknown                                 OBSERVER / AGENCY
unknown             unknown             unknown             REC # / TYPE / VERS
unknown             unknown                                 ANT # / TYPE
        0.0000        0.0000        0.0000                  APPROX POSITION XYZ
        0.0000        0.0000        0.0000                  ANTENNA: DELTA H/E/N
  2019    06    05    01    52   03.7652649                 TIME OF FIRST OBS
G    4 C1C L1C D1C S1C                                      SYS / # / OBS TYPES
R    4 C1C L1C D1C S1C                                      SYS / # / OBS TYPES
E    4 C1C L1C D1C S1C                                      SYS / # / OBS TYPES
                                                            END OF HEADER
> 2019 06 05 01 52 20.2019999  0  6
G05  21643026.31606 113734869.95806     -2084.85906        40.00006
G13  20940404.71107 110042563.43007       650.48707        45.00007
G15  21819537.83307 114662444.00207      2552.08207        46.00007
G29  22272808.61807 117044397.73607     -2139.16707        45.00007
G30  24262711.51305 127501402.06305      -245.06005        34.00005
E13  24476988.50208 128627441.38908       970.55808        49.00008
```

## Third party options

If you'd rather convert the files yourself without using our platform, you just
have to know that any tool that is able to parse ublox binary format (`ubx`) will
convert your files into Rinex format. Two examples are UNAVCO's `teqc` and RTKLIB's
`convbin` (or its Windows GUI equivalent `rtkconv`). 


For the examples given in the following sections, you will need the sample `rok` file [argonaut_cam.rok](https://github.com/rokubun/ursula-docs/raw/master/assets/argonaut_cam.rok).

### teqc

To convert the `rok` file into Rinex 2 (adding some header fields), use the
following command:

```bash
marker_name="ARGO"
rx_type="argonaut"
ant_type="internal/patch"
teqc  -ublox ubx -O.rt ${rx_type} -O.at ${ant_type} -O.mo ${marker_name} argonaut_cam.rok > argo0580.18o
```

### convbin

If you'r rather use `convbin`, please use this command (to output the data in
Rinex 3.03 format):

```bash
marker_name="ARGO"
rx_number="03018-1-0xxx"
rx_type="argonaut"
ant_type="internal/patch"
convbin -v 3.03 -od -os -r ubx -o  argo0580.18o -hr "${rx_number}/${rx_type}/" -ha "/${ant_type}" -hm ${marker_name} argonaut_cam.rok
```
