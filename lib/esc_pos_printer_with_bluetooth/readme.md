all data for esc pos print here

1. YouTube url -> https://youtu.be/mKx-K2wpg7g
2. GitHub url -> https://github.com/Sarbad0r/flutter_esc_pos_printer

> **_NOTE:_** Do not forget to put this line of code in your AndroidManifest.xml file

    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />

> **_NOTE:_** If you selected project with kotlin do not forget to put this line of codes in your
> MainActivity.kt file

    //package com.example.my_store

    import android.annotation.SuppressLint
    import android.bluetooth.BluetoothAdapter
    import android.bluetooth.BluetoothClass.Device
    import android.bluetooth.BluetoothDevice
    import android.bluetooth.BluetoothManager
    import android.content.Context
    import android.graphics.Bitmap
    import android.graphics.BitmapFactory
    import android.os.Bundle
    import com.rt.printerlibrary.bean.BluetoothEdrConfigBean
    import com.rt.printerlibrary.cmd.Cmd
    import com.rt.printerlibrary.cmd.EscFactory
    import com.rt.printerlibrary.connect.PrinterInterface
    import com.rt.printerlibrary.enumerate.BmpPrintMode
    import com.rt.printerlibrary.enumerate.CommonEnum
    import com.rt.printerlibrary.exception.SdkException
    import com.rt.printerlibrary.factory.cmd.CmdFactory
    import com.rt.printerlibrary.factory.connect.BluetoothFactory
    import com.rt.printerlibrary.factory.connect.PIFactory
    import com.rt.printerlibrary.factory.printer.PrinterFactory
    import com.rt.printerlibrary.factory.printer.ThermalPrinterFactory
    import com.rt.printerlibrary.printer.RTPrinter
    import com.rt.printerlibrary.setting.BitmapSetting
    import com.rt.printerlibrary.setting.CommonSetting
    import io.flutter.embedding.android.FlutterActivity
    import io.flutter.embedding.engine.FlutterEngine
    import io.flutter.plugin.common.MethodChannel

    class MainActivity : FlutterActivity() { private val CHANNEL = PrinterStrings.channel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                PrinterStrings.connectCommand -> {
                    val printerMac = call.argument<String>(PrinterStrings.macArg)
                    if (printerMac != null) {
                        PrinterManager.connect(printerMac)
                    }
                }
                PrinterStrings.printCommand -> {
                    val imgPath = call.argument<String>(PrinterStrings.imgPathArg)
                    if (imgPath != null) {
                        PrinterManager.printImg(imgPath)
                    }
                }
            }
        }
    }

    }

    class PrinterStrings { 
        companion object { 
        // channel name const val channel = "android.flutter/printer"
        // commands
        const val connectCommand = "printer_connect"
        const val printCommand = "printer_print"
        // arguments
        const val macArg = "printer_mac"
        const val imgPathArg = "img_path"
        }
    }

    class PrintersWidth { 
        companion object { 
            const val mm_4inch = 104 //mm
            const val mm_3inch = 80 
            const val mm_72 = 72 //mm 
            const val px_3inch = 575 //mm 
            const val px_4inch = 820 //mm
        }
    }
    
    class PrinterManager { 
        companion object { 
            private lateinit var rtPrinter:
            RTPrinter<BluetoothEdrConfigBean>
            private lateinit var mBluetoothAdapter: BluetoothAdapter private lateinit var pairedDeviceList:
            List<BluetoothDevice>

            @SuppressLint("MissingPermission")
            private fun initPrinter() {
                val printerFactory: PrinterFactory = ThermalPrinterFactory()
                rtPrinter = printerFactory.create() as RTPrinter<BluetoothEdrConfigBean>
    
                mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                mBluetoothAdapter.startDiscovery()
    
                pairedDeviceList = ArrayList(mBluetoothAdapter.bondedDevices)
            }
    
            private fun openPortWithDevice(device: BluetoothDevice) {
                val configObj: Any = BluetoothEdrConfigBean(device)
                val bluetoothEdrConfigBean = configObj as BluetoothEdrConfigBean
                openPortWithDevice(bluetoothEdrConfigBean)
            }
    
            private fun openPortWithDevice(bluetoothEdrConfigBean: BluetoothEdrConfigBean): Int {
                try {
                    val piFactory: PIFactory = BluetoothFactory()
                    val printerInterface: PrinterInterface<Any> = piFactory.create()
                    rtPrinter.setPrinterInterface(printerInterface)
                    rtPrinter.connect(bluetoothEdrConfigBean)
                    return 0
                } catch (e: Exception) {
                    e.printStackTrace()
                    return -1
                }
            }
    
            @SuppressLint("MissingPermission")
            fun connect(printerMac: String) {
                initPrinter()
                for (i in 0 until pairedDeviceList.size) {
                    val dev: BluetoothDevice = pairedDeviceList[i]
                    if (dev.address == printerMac) {
                        mBluetoothAdapter.cancelDiscovery()
                        openPortWithDevice(dev)
                    }
                }
            }
    
            fun printImg(imgPath: String) {
                    val mBitmap: Bitmap = BitmapFactory.decodeFile(imgPath)
                    Thread {
                        val cmdFactory: CmdFactory = EscFactory()
                        val cmd: Cmd = cmdFactory.create()
                        cmd.append(cmd.getHeaderCmd())
        
                        val commonSetting = CommonSetting()
                        commonSetting.align = CommonEnum.ALIGN_MIDDLE
                        cmd.append(cmd.getCommonSettingCmd(commonSetting))
        
                        val bitmapSetting = BitmapSetting()
                        bitmapSetting.bmpPrintMode = BmpPrintMode.MODE_SINGLE_COLOR
                        bitmapSetting.bimtapLimitWidth = PrintersWidth.mm_3inch * 8
        
                        try {
                            cmd.append(cmd.getBitmapCmd(bitmapSetting, mBitmap))
                        } catch (e: SdkException) {
                            e.printStackTrace()
                        }
    
                        cmd.append(cmd.getLFCRCmd())
                        cmd.append(cmd.getLFCRCmd())
                        cmd.append(cmd.getLFCRCmd())
                        cmd.append(cmd.getLFCRCmd())
                        cmd.append(cmd.getLFCRCmd())
                        cmd.append(cmd.getLFCRCmd())
                        rtPrinter.connectState
                        if (rtPrinter != null) {
                            rtPrinter.writeMsg(cmd.getAppendCmds()) // Sync Write
                        }
    
                    }.start()
                }
        }
    }

> **_NOTE:_** If you selected project with Java do not forget to put this line of codes in your
> MainActivity.java file

    //package com.example.my_store

    import android.annotation.SuppressLint;
    import android.bluetooth.BluetoothAdapter;
    import android.bluetooth.BluetoothDevice;
    import android.content.ContextWrapper;
    import android.content.Intent;
    import android.content.IntentFilter;
    import android.graphics.Bitmap;
    import android.graphics.BitmapFactory;
    import android.os.BatteryManager;
    import android.os.Build.VERSION;
    import android.os.Build.VERSION_CODES;
    import android.os.Bundle;
    
    import androidx.annotation.NonNull;
    
    import com.rt.printerlibrary.bean.BluetoothEdrConfigBean;
    import com.rt.printerlibrary.cmd.Cmd;
    import com.rt.printerlibrary.cmd.EscFactory;
    import com.rt.printerlibrary.connect.PrinterInterface;
    import com.rt.printerlibrary.enumerate.BmpPrintMode;
    import com.rt.printerlibrary.enumerate.CommonEnum;
    import com.rt.printerlibrary.exception.SdkException;
    import com.rt.printerlibrary.factory.cmd.CmdFactory;
    import com.rt.printerlibrary.factory.connect.BluetoothFactory;
    import com.rt.printerlibrary.factory.connect.PIFactory;
    import com.rt.printerlibrary.factory.printer.PrinterFactory;
    import com.rt.printerlibrary.factory.printer.ThermalPrinterFactory;
    import com.rt.printerlibrary.printer.RTPrinter;
    import com.rt.printerlibrary.setting.BitmapSetting;
    import com.rt.printerlibrary.setting.CommonSetting;
    
    import java.util.ArrayList;
    import java.util.List;
    
    import io.flutter.embedding.android.FlutterActivity;
    import io.flutter.embedding.engine.FlutterEngine;
    import io.flutter.plugin.common.MethodChannel;

    public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = PrinterStrings.channel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                           if(call.method.equals(PrinterStrings.connectCommand)){
                               String printerMac = call.argument(PrinterStrings.macArg);
                               if(printerMac!=null){
                                   PrinterManager.connect(printerMac);
                               }
                           }
                           else if(call.method.equals(PrinterStrings.printCommand)){
                               String imgPath = call.argument(PrinterStrings.imgPathArg);
                               if(imgPath!=null){
                                   PrinterManager.printImg(imgPath);
                               }
                           }
                        }
                );
        }
    }


    class PrinterStrings {
        // channel name
        static String channel = "android.flutter/printer";
        //commands
        static String connectCommand = "printer_connect";
        static String printCommand = "printer_print";
        // arguments
        static String macArg = "printer_mac";
        static String imgPathArg = "img_path";
    }

    class PrintersWidth{

        public static int mm_4inch = 104; //mm
        public static int mm_3inch = 80;
        public static int mm_72 = 72; //mm
        public static int px_3inch = 575; //mm
        public static int px_4inch = 820; //mm

    }

    class PrinterManager {

            private static RTPrinter rtPrinter;
            private static BluetoothAdapter mBluetoothAdapter;
            private static List<BluetoothDevice> pairedDeviceList ;
        
            @SuppressLint("MissingPermission")
            private static void initPrinter() {
        
                PrinterFactory printerFactory = new ThermalPrinterFactory();
        
                rtPrinter = printerFactory.create();
        
                mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        
                mBluetoothAdapter.startDiscovery();
        
                pairedDeviceList = new ArrayList<>(mBluetoothAdapter.getBondedDevices());
    
             private static void openPortWithDevice(BluetoothDevice device) {
    
            Object configObj = new BluetoothEdrConfigBean(device);
            BluetoothEdrConfigBean bluetoothEdrConfigBean = (BluetoothEdrConfigBean) configObj;
            openPortWithDevice(bluetoothEdrConfigBean);
        }
    
    
            private static int openPortWithDevice(BluetoothEdrConfigBean bluetoothEdrConfigBean) {
        
                try {
                    PIFactory piFactory = new BluetoothFactory();
                    PrinterInterface printerInterface = piFactory.create();
                    rtPrinter.setPrinterInterface(printerInterface);
                    rtPrinter.connect(bluetoothEdrConfigBean);
                    return  0;
                } catch (Exception e) {
                    e.printStackTrace();
                    return  -1;
                }
            }
        
        
        
            @SuppressLint("MissingPermission")
            static void connect(String printerMac){
                initPrinter();
                for(int i=0 ; i < pairedDeviceList.size() ; i++){
                    BluetoothDevice dev = pairedDeviceList.get(i);
                    if( dev.getAddress().equals(printerMac) ){
                        mBluetoothAdapter.cancelDiscovery();
                        openPortWithDevice(dev);
                    }
                }
            }

            static void printImg(String imgPath){
            Bitmap mBitmap= BitmapFactory.decodeFile(imgPath);
            new Thread(() -> {
    
                CmdFactory cmdFactory = new EscFactory();
                Cmd cmd = cmdFactory.create();
                cmd.append(cmd.getHeaderCmd());
    
                CommonSetting commonSetting = new CommonSetting();
                commonSetting.setAlign(CommonEnum.ALIGN_MIDDLE);
                cmd.append(cmd.getCommonSettingCmd(commonSetting));
    
                BitmapSetting bitmapSetting = new BitmapSetting();
                bitmapSetting.setBmpPrintMode(BmpPrintMode.MODE_SINGLE_COLOR);
                bitmapSetting.setBimtapLimitWidth(PrintersWidth.mm_3inch * 8);
    
                try {
                    cmd.append(cmd.getBitmapCmd(bitmapSetting, mBitmap));
                } catch (SdkException e) {
                    e.printStackTrace();
                }
    
                cmd.append(cmd.getLFCRCmd());
                cmd.append(cmd.getLFCRCmd());
                cmd.append(cmd.getLFCRCmd());
                cmd.append(cmd.getLFCRCmd());
                cmd.append(cmd.getLFCRCmd());
                cmd.append(cmd.getLFCRCmd());
                rtPrinter.getConnectState().name();
                if (rtPrinter != null) {
                    rtPrinter.writeMsg(cmd.getAppendCmds());//Sync Write
                }
    
            }).start();
    
            }

        }
    }