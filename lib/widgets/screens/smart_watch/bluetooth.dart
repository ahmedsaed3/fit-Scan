import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveHeartRate extends StatefulWidget {
  @override
  _LiveHeartRateScreenState createState() => _LiveHeartRateScreenState();
}

class _LiveHeartRateScreenState extends State<LiveHeartRate> {
  BluetoothDevice? _device;
  BluetoothCharacteristic? _heartRateChar;
  int _heartRate = 0;
  List<HeartRateData> heartRateList = [];
  StreamSubscription<BluetoothAdapterState>? _bluetoothStateSubscription;

  // Stream controller for real-time updates
  StreamController<int> heartRateStreamController = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  void _checkBluetoothState() {
    _bluetoothStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.off) {
        _showBluetoothSheet();
      } else if (state == BluetoothAdapterState.on) {
        _scanAndConnect();
      }
    });
  }

  void _showBluetoothSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        height: 250,
        child: Column(
          children: [
            Icon(Icons.bluetooth_disabled, size: 50, color: Colors.red),
            SizedBox(height: 10),
            Text(
              "Bluetooth is turned off",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Please enable Bluetooth to connect to your heart rate device."),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // AppSettings.openBluetoothSettings();
              },
              child: Text("OK"),
            ),
          ],
        ),
      ),
    );
  }

  void _scanAndConnect() async {
    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult r in results) {
        if (r.device.name.contains("X8UltraMax")) {
          FlutterBluePlus.stopScan();
          await _connectToDevice(r.device);
          return;
        }
      }
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      List<BluetoothService> services = await device.discoverServices();

      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.properties.notify) {
            setState(() {
              _device = device;
              _heartRateChar = characteristic;
            });

            await Future.delayed(Duration(seconds: 1));
            _readHeartRate();
            return;
          }
        }
      }
    } catch (e) {
      print("Connection failed: $e");
    }
  }

  void _readHeartRate() async {
    if (_heartRateChar != null) {
      await _heartRateChar!.setNotifyValue(true);
      _heartRateChar!.value.listen((value) {
        if (value.isNotEmpty) {
          int newHeartRate = value.length > 1 ? value[1] : value[0];

          heartRateList.add(HeartRateData(DateTime.now(), newHeartRate));

          if (heartRateList.length > 30) {
            heartRateList.removeAt(0);
          }

          heartRateStreamController.add(newHeartRate); // Broadcasting live data

          if (mounted) {
            setState(() {
              _heartRate = newHeartRate;
            });
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _bluetoothStateSubscription?.cancel();
    _heartRateChar?.setNotifyValue(false);
    _device?.disconnect();
    heartRateStreamController.close(); // Closing the stream
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Heart Rate")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<int>(
            stream: heartRateStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "Live Heart Rate: ${snapshot.data} BPM",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              title: ChartTitle(text: 'Heart Rate Over Time'),
              series: <LineSeries<HeartRateData, DateTime>>[
                LineSeries<HeartRateData, DateTime>(
                  dataSource: heartRateList,
                  xValueMapper: (HeartRateData hr, _) => hr.time,
                  yValueMapper: (HeartRateData hr, _) => hr.rate,
                  name: 'Heart Rate',
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeartRateData {
  final DateTime time;
  final int rate;
  HeartRateData(this.time, this.rate);
}
