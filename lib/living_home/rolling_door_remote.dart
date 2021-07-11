import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class RollingDoor extends StatefulWidget {
  @override
  _RollingDoorState createState() => _RollingDoorState();
}

class _RollingDoorState extends State<RollingDoor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Điều khiển cửa cuốn'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 5,
            child: Image.asset(
              'assets/images/garage.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20,),
          buildActiveContainer(),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildOpenCloseButton(
                  'Mở',
                  Icons.arrow_drop_up,
                  Colors.blue,
                ),
                SizedBox(
                  width: 25,
                ),
                buildOpenCloseButton(
                  'Đóng',
                  Icons.arrow_drop_down,
                  Colors.green,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLockButton(
                  'Khóa',
                  Icons.lock,
                  Colors.black,
                ),
                SizedBox(
                  width: 25,
                ),
                buildStopButton(
                  'Dừng',
                  Icons.stop,
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel() {
    return Container(
      child: Row(
        children: [
          Text(
            'Cửa chính',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          Icon(
            Icons.share,
          ),
        ],
      ),
    );
  }

  Widget buildActiveContainer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/blue_circle.png',
            width: 16,
            height: 16,
          ),
          SizedBox(width: 10,),
          Text(
            'Đã mở hết!',
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget buildOpenCloseButton(String text, IconData icon, Color iconColor) {
    return Container(
      height: 150,
      width: 150,
      child: ClipPolygon(
        sides: 6,
        borderRadius: 10.0,
        // Default 0.0 degrees
        rotate: 90.0,
        // Default 0.0 degrees
        boxShadows: [
          PolygonBoxShadow(color: Colors.black, elevation: 3.0),
          // PolygonBoxShadow(color: Colors.grey, elevation: 3.0)
        ],
        child: FlatButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Icon(
                icon,
                size: 80,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLockButton(String text, IconData icon, Color iconColor) {
    return Container(
      height: 150,
      width: 150,
      child: ClipPolygon(
        sides: 6,
        borderRadius: 10.0,
        // Default 0.0 degrees
        rotate: 90.0,
        // Default 0.0 degrees
        boxShadows: [
          PolygonBoxShadow(color: Colors.black, elevation: 3.0),
          // PolygonBoxShadow(color: Colors.grey, elevation: 3.0)
        ],
        child: FlatButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 70,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStopButton(String text, IconData icon, Color iconColor) {
    return Container(
      height: 150,
      width: 150,
      child: ClipPolygon(
        sides: 6,
        borderRadius: 10.0,
        // Default 0.0 degrees
        rotate: 90.0,
        // Default 0.0 degrees
        boxShadows: [
          PolygonBoxShadow(color: Colors.black, elevation: 3.0),
          // PolygonBoxShadow(color: Colors.grey, elevation: 3.0)
        ],
        child: FlatButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 80,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
