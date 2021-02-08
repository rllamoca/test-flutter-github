# testgithub

Proyecto para la demostracion de los api de github en flutter

## Getting Started

Para instalar este proyecto, necesitas tener flutter instalado, 
puede seguir los pasos descritos en el siguiente link:
https://flutter.dev/docs/get-started/install

Una vez instalado flutter, clonamos el proyecto
git clone https://github.com/rllamoca/test-flutter-github.git

Ya descargado nuestro proyecto , nos dirigimos a la carpeta de nuestro proyecto y obtenemos las dependencias del proyecto con el comando
flutter packages get

Para ejecutar en nuestros dispositivos seguimos los siguientes pasos
ANDROID
- Listamos nuestros dispositivos conectados con el comando:
    flutter devices
    ![alt text](http://54.39.20.126/ftf/flutter_devices.png)

- Una vez realizado podremos correr nuestra app utilizando el comando:
    flutter run -d <<ID DE DISPOSITIVO>> 


IOS
- Para ios compilaremos el proyecto para asegurarnos que se cumplan todas las dependencias con el comando:
    flutter build ios
- Posteriormente abrimos el proyecto xcworkspace en la ruta:
    /ios/Runner.xcworkspace.
    El cual abriremos con XCode
- Elegiremos un emulador para su ejecución (en el caso de prueba en dispositivos reales se necesita una cuenta apple developer con membresia)
    ![alt text](http://54.39.20.126/ftf/xcode.png)


DEMO ANDROID
    ![alt text](http://54.39.20.126/ftf/android/0.jpg)
    ![alt text](http://54.39.20.126/ftf/android/1.jpg)
    ![alt text](http://54.39.20.126/ftf/android/2.jpg)
    ![alt text](http://54.39.20.126/ftf/android/3.jpg)
    ![alt text](http://54.39.20.126/ftf/android/4.jpg)

DEMO IOS
    ![alt text](http://54.39.20.126/ftf/ios/0.png)
    ![alt text](http://54.39.20.126/ftf/ios/1.png)
    ![alt text](http://54.39.20.126/ftf/ios/2.png)
    ![alt text](http://54.39.20.126/ftf/ios/3.png)
    ![alt text](http://54.39.20.126/ftf/ios/4.png)


DEMO APK
    [Demo APK FulltimeForce](http://54.39.20.126/ftf/demo_github.apk)