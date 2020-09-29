# gclone-batch-file
Windows Batch File scripts to run gclone using a text UI.

GC Remote and GC Local are batch files written/edited by me and Roshanconnor to provide easier use of gclone through a "text ui" via the command line. It is a double click and run file.

GC remote is the provided .bat in the guide, and is aimed at use for functions between 2 team drives assuming you have followed the guide and pre-requisites. The functions are either logically named or have explanations attached, and you just need to input the folder id of the source and destination. Making life more convenient for the major use cases of gclone (between 2 team drives).

Similarly, GC local is made for use between a local source and a team drive, and vice versa. So the input for source and destinations will be slightly different, where a local source would be something like "C:\Users\name\Desktop\Empty folder test" and "remote:\path\folder". Take note to remove the rclone.conf file within the folder if you have used GC remote before this, as it will override and only show gc: as the remote, instead of the pre-configured ones you have set up before
