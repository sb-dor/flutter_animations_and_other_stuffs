i used this packages:

    camera: [version]
    video_player: [version]
    gal: [version]
    permission_handler: [version]

do not forget to do package's device configuration
"gal" package for saving picture or video in gallery
permission_handler is used for getting permission for saving data in gallery


android permission to save in storage 

    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

ios permission to save in storage 

    <key>NSPhotoLibraryAddUsageDescription</key>     Required
    <key>NSPhotoLibraryUsageDescription</key>        Required for saving to album