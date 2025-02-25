# Bluetooth Yönetimi Dokümantasyonu

## BluetoothManager Sınıfı

### Genel Bakış
`BluetoothManager` sınıfı, uygulamanın Bluetooth işlemlerini merkezi olarak yöneten bir singleton sınıftır.

### Temel Özellikler
1. **Cihaz Tarama**
   - `startScan()`: Bluetooth cihazlarını taramaya başlar
   - `stopScan()`: Taramayı durdurur
   - Otomatik timeout ile tarama yönetimi

2. **Bağlantı Yönetimi**
   - `connectToDevice()`: Seçili cihaza bağlanır
   - `disconnectFromDevice()`: Bağlantıyı sonlandırır
   - Bağlantı durumu kontrolü

3. **Veri İletişimi**
   - `sendData()`: Cihaza veri gönderir
   - `readData()`: Cihazdan veri okur
   - Veri formatı: UTF-8 string

### Kullanım Örneği
```dart
// Singleton instance alma
final bluetoothManager = BluetoothManager();

// Tarama başlatma
await bluetoothManager.startScan();

// Cihaza bağlanma
await bluetoothManager.connectToDevice(selectedDevice);

// Veri gönderme
await bluetoothManager.sendData("1"); // Start komutu
```

### Önemli Metodlar

#### 1. Cihaz Tarama
```dart
Future<void> startScan() async {
  // Bluetooth açık mı kontrol et
  // Taramayı başlat
  // Timeout ayarla
}
```

#### 2. Bağlantı Kurma
```dart
Future<void> connectToDevice(BluetoothDevice device) async {
  // Bağlantı kurma
  // Karakteristikleri keşfetme
  // Bağlantı durumunu güncelleme
}
```

#### 3. Veri Gönderme
```dart
Future<void> sendData(String data) async {
  // Veriyi UTF-8'e çevir
  // Karakteristiğe yaz
  // Sonucu kontrol et
}
```

### Hata Yönetimi
- Bluetooth kapalıysa kullanıcıya bildirim
- Bağlantı kopması durumunda otomatik yeniden bağlanma
- Timeout durumlarında uygun hata mesajları

### İzinler
Android için gerekli izinler:
```xml
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```

iOS için gerekli izinler:
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Şarj istasyonu ile iletişim için Bluetooth gereklidir</string>
``` 