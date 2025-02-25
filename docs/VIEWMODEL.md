# ViewModel Katmanı Dokümantasyonu

## HomeViewModel

### Genel Bakış
`HomeViewModel` sınıfı, MVVM mimarisinin ViewModel katmanını temsil eder ve uygulama mantığını yönetir.

### Temel Sorumluluklar
1. **Durum Yönetimi**
   - Bluetooth bağlantı durumu
   - Seçili mod (Plug and Play / Charge Control)
   - Amper ve faz değerleri
   - Sıcaklık ve güç verileri

2. **Veri İşleme**
   - Bluetooth'dan gelen verilerin parse edilmesi
   - Güç hesaplamaları
   - Durum güncellemeleri

3. **Kullanıcı Etkileşimleri**
   - Şarj başlatma/durdurma
   - Mod değiştirme
   - Amper/faz seçimi

### Önemli Özellikler

#### 1. Veri Yönetimi
```dart
class HomeViewModel extends ChangeNotifier {
  List<int> parsedDataList = [];
  String selectedMode = "Charge control";
  int selectedAmper = 6;
  String selectedPhase = "Tek Faz";
}
```

#### 2. Şarj Kontrolü
```dart
Future<void> handleStartCharging(BuildContext context, BluetoothDevice? selectedDevice, int selectedAmper) async {
  // Amper komutunu gönder
  // Başarı mesajı göster
  // 4 saniye bekle
  // Start komutunu gönder
}
```

#### 3. Veri Güncelleme
```dart
void updateData(List<int> newData) {
  parsedDataList = newData;
  notifyListeners();
}
```

### Kullanım Örneği
```dart
final viewModel = Provider.of<HomeViewModel>(context);

// Şarj başlatma
await viewModel.handleStartCharging(context, device, 32);

// Mod değiştirme
viewModel.setChargeMode("Plug and play");

// Amper değiştirme
viewModel.setSelectedAmper(16);
```

### State Management
- Provider paketi kullanılarak state yönetimi
- ChangeNotifier sınıfından türetme
- `notifyListeners()` ile UI güncelleme

### Veri Akışı
1. Bluetooth'dan veri alımı
2. Veri parse işlemi
3. State güncelleme
4. UI bilgilendirme

### Hata Yönetimi
- Try-catch blokları ile hata yakalama
- Kullanıcıya uygun hata mesajları
- Bağlantı kopması durumunda recovery

### Önemli Metodlar

#### 1. Şarj Başlatma
```dart
Future<void> handleStartCharging() async {
  // İşlem kontrolü
  // Amper komutu
  // Başarı mesajı
  // Gecikme
  // Start komutu
}
```

#### 2. Şarj Durdurma
```dart
Future<void> handleStopCharging() async {
  // Bağlantı kontrolü
  // Stop komutu
  // Kullanıcı bildirimi
}
```

#### 3. Mod Değiştirme
```dart
void setChargeMode(String mode) {
  // Mod güncelleme
  // Tercihleri kaydetme
  // UI güncelleme
}
``` 