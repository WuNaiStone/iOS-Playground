## DemoLBS

Demo for iOS LBS related.

### CoreLocation

基本步骤:
```
import CoreLocation,
ViewController 继承 CLLocationManagerDelegate 协议,
实现CLLocationManager的didUpdateLocations, didUpdateToLocation等方法,
开始定位: 调用CLLocationManager的startUpdatingLocation方法.
设备自身的定位要开启.
```
请参考博客:[iOS --- 使用CoreLocation来获取地理位置信息](http://blog.csdn.net/icetime17/article/details/45230483)

### MapKit

基本步骤:
```
import MapKit
ViewController 继承 MKMapViewDelegate 协议
添加一个MapKit View
准备一个相应的region信息, 即以哪为中心, 方圆多少范围
在mapView中设置该region即可
添加地理位置的标注annotation
地理位置标注添加到map中的相应操作
```
请参考博客:[iOS --- 地图框架MapKit的简单使用](http://blog.csdn.net/icetime17/article/details/45251755)
