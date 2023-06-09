# Usage examples

This section includes several usage examples that cover most of the use cases
that Virtual-lab could support. Go to the [quick start guide](../quickstart) for a
n example of a basic usage with a single rover file.

This section will use the term _rover_ instead of _receiver_ in order to
distinguish it from a _reference receiver_ (or _base receiver_), which is
usually static and is used to provide corrections to the (usually) moving
(roving) receiver.

## Rover and base files

If the area you are surveying does not have a nearby CORS station, you can use
your own reference GNSS receiver. During the campaign make sure you collect
data at the same time as your rover and then process the rover GNSS data together
with the GNSS data from the base station.

To execute this example, follow these steps:

1- Download one or several of the test datasets listed below

Use case description| Rover file | Base station file
:---:|:---:|:---:
DJI Phantom 4 RTK drone [`*`] | [Rover](https://Virtual-lab-docs.s3.eu-central-1.amazonaws.com/DJI_with_cam_events/101_0082_Rinex.rnx) | [Base station](https://Virtual-lab-docs.s3.eu-central-1.amazonaws.com/DJI_with_cam_events/RTK134_202102051543_13ALG6P0050051.DAT)
Topodrone on a Mavic 2 Pro | [Rover](https://Virtual-lab-docs.s3.eu-central-1.amazonaws.com/Topodrone/TopoDrone.ubx) | [Base station](https://Virtual-lab-docs.s3.eu-central-1.amazonaws.com/Topodrone/MARE00ESP_R_20201201204_22M_01S_MO.rnx)
Rokbun's ARGONAUT on a drone | [Rover](https://Virtual-lab-docs.s3.eu-central-1.amazonaws.com/Rokubun+ARGONAUT/argonaut_cam.rok) | No base station
Septentrio Mosaic X5 driving | [Rover](https://Virtual-lab-docs.s3.eu-central-1.amazonaws.com/Cardedeu_Driving_MosaicX5_1Hz/XXXX00CAT_R_20203401333_01H_01S_MO.rnx) | [Base station](https://Virtual-lab-docs.s3.eu-central-1.amazonaws.com/Cardedeu_Driving_MosaicX5_1Hz/MARE00ESP_R_20203401333_82M_01S_MO.rnx)

[`*`] Courtesy of [Terradroneology](https://terradroneology.com/)

2- Log in with your account and Virtual-lab and go to the "GNSS processor" tab.

3- Drag-and-drop the two downloaded files at the _rover_ and _base station_ boxes,
as shown below.

![Upload rover and base station files](images/example_base_upload.png "Upload rover and base station files")

4- Press "Process file" and wait for the process to finish. The rest of the steps
are the same as those of the [quick start guide](../quickstart).

An important note to consider is regarding the **base station coordinates**. If the
input file is in Rinex format and you are confident that the coordinates of the
`APPROX POSITION XYZ` header field are accurate, you do not need to do anything else. However,
you can indicate a proper set of coordinates for the base station in the field
**"External base station position (optional)"** in the form of latitude, longitude
and height. Latitude and longitude shall be expressed in meters while the height
should be expressed in height above the ellipsoid.

Also note that the formats supported by the base station are the same as the 
ones supported by the rover receiver.

## Processing smartphone data

One of the features of Virtual-lab is the ability to process GNSS raw measurements
logged by smartphones. To do this, you can record such data using various
alternatives:

- Store RINEX data using an app (from e.g. Geo++ or NSL)
- Store raw measurements using Google's [GNSS logger](https://github.com/google/gps-measurement-tools/tree/master/GNSSLogger) 

We recommend the usage of Google's app as Virtual-lab can directly ingest the files
generated by it. Just start the app and make sure that both the **Location**
and **Measurements** switches are turned on (see left panel of lower figure).
Then head towards the **LOG** tab and click **START LOG** (at the bottom of
the screen). This will start recording the measurements.

Main GNSS logger page            |  Log tab
:-------------------------:|:-------------------------:
![Main page](images/gnss_logger_01_main_page.jpg)  |  ![Log page](images/gnss_logger_02_log_page.jpg)

Once the data take is finished, you will have a `gnss_log_<date>.txt` file in your smartphone
(usually under the folder `gnss_log`). To process this file you have 2 options:

- Directly from the smartphone: open the smartphone browser and go to the
  Virtual-lab web page. Head over "GNSS processor" and select the file you want
  to process, the smartphone will open then the app to browse the files you
  have in your device. You will be able then to select and upload the file.
- From a desktop computer: transfer the file to your computer and follow the
  process described in the [quickstart](../quickstart)

As a bonus, Virtual-lab will also deliver, besides the [usual files](../manual#gnss-processor-files), the Rinex files
that resulted from the conversion of the GNSS logger data.

## Static receiver, RTCM 3 format

The use case for this example is in the event that you deploy a base station
so that it transmits the data via NTRIP to an NTRIP caster. Rover receivers
can then connect to this caster but need the precise coordinates of this base
station, so you use Virtual-lab to get those precise coordinates.
station.

Once the base station is serving data to the NTRIP caster, the operator can
record data into `rtcm3` format using e.g. [rtklib](http://www.rtklib.com)'s `str2str` tool.
After you log in into Virtual-lab, send the data, as shown in the following figure
(for a data file `bcln0.rtcm3`)

![Process an RTCM3 file in static mode](images/howto_rtcm3_static.png "Process an RTCM3 file in static mode")

One point to take into account is the fact that the file conversion within
Virtual-lab does not allow the user to specify the approximate date of the file.
Therefore, unless the RTCM3 file is recent (within the same GPS week), the
RTCM3 file will not he processed. Therefore, the recommended approach would
be to convert the rtcm3 file into Rinex and then upload it to the service.
If you use `rtklib`'s `convbin` tool, you can launch the command:

```bash
convbin -r rtcm3 -v 3.03 -f 3 -scan -o bcln0.rinex bcln0.rtcm3
```

Then upload the file `bcln0.rinex` to Virtual-lab.

You will get this station precise coordinates that can be further used by rovers using this station in the NTRIP caster.
