
add this code in your AndroidManifest.xml
    
    <activity
    
        <meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="http" android:host="avazsho.com" />
                <data android:scheme="https" android:host="avazsho.com"/>
            </intent-filter>

     </activity>

you can write any other url in that place where I wrote avazsho.com.
And also remember to put inside activity