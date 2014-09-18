cd junit-report
rm TEST-all.xml
cd ..
cd ..

set devicesId=e8dab292 

adb shell input keyevent 3
adb -s e8dab292 -d uninstall com.baidu.wearable
adb -s e8dab292 -d uninstall com.dulife.test

adb -s e8dab292 install -r Wearable/bin/Wearable-release.apk	
adb -s e8dab292 install -r bin/WearableTest.apk

adb -s e8dab292 -d shell am instrument -e outfile "TEST-all.xml" -e class com.dulife.test.version_1_0_9 -w com.dulife.test/com.dulife.test.instrumentation.InstrumentationTestRunner

adb -s e8dab292 -d logcat -d -v time > ./result/e8dab292.txt

cd result
adb pull /mnt/sdcard/robotium/TEST-all.xml junit-report
java -jar report.jar