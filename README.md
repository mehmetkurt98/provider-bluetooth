# Elektrikli Araç Şarj İstasyonu Kontrol Uygulaması

## Proje Hakkında
Bu uygulama, elektrikli araç şarj istasyonlarını Bluetooth üzerinden kontrol etmek için geliştirilmiş bir Flutter uygulamasıdır. MVVM (Model-View-ViewModel) mimarisi kullanılarak geliştirilmiştir.

## Özellikler
- Bluetooth bağlantısı ve yönetimi
- Şarj modu seçimi (Plug and Play / Charge Control)
- Amper değeri ayarlama (6A, 10A, 16A, 32A)
- Faz seçimi (Tek Faz / Üç Faz)
- Güç göstergesi (kW cinsinden)
- Sıcaklık takibi
- Çoklu dil desteği (TR/EN/DE)
- Kullanıcı tercihleri saklama
- Bluetooth bağlantısı durumunu takip etme
- Şarj durumunu takip etme

## Proje Yapısı

```
lib/
├── constants/          # Sabit değerler (resimler, renkler vb.)
├── controller/         # Uygulama kontrolcüleri
├── model/             # Veri modelleri
├── utils/             # Yardımcı sınıflar ve fonksiyonlar
├── view/              # UI bileşenleri
│   └── widgets/       # Yeniden kullanılabilir widget'lar
├── view_model/        # İş mantığı ve veri yönetimi
└── main.dart          # Uygulama giriş noktası
```

## Temel Bileşenler

### 1. Bluetooth Yönetimi
- `BluetoothManager` singleton sınıfı ile merkezi Bluetooth yönetimi
- Cihaz tarama, bağlanma ve veri gönderme işlemleri
- Bağlantı durumu takibi

### 2. Veri Yönetimi
- `SharedPreferencesService` ile kullanıcı tercihlerinin saklanması
- `HomeViewModel` ile uygulama durumu yönetimi
- Provider paketi ile state management

### 3. UI Bileşenleri
- Responsive tasarım için `DeviceInfo` singleton kullanımı
- Modüler widget yapısı
- Kolay lokalizasyon için Easy Localization desteği

## Kullanılan Teknolojiler
- Flutter
- Provider (State Management)
- flutter_blue_plus (Bluetooth İletişimi)
- shared_preferences (Veri Saklama)
- easy_localization (Çoklu Dil Desteği)

## Kurulum
1. Flutter SDK'yı yükleyin
2. Projeyi klonlayın
3. Bağımlılıkları yükleyin:
```bash
flutter pub get
```
4. Uygulamayı çalıştırın:
```bash
flutter run
```

## Önemli Notlar
- Bluetooth bağlantısı için konum izinleri gereklidir
- Android 12+ için Bluetooth izinleri manuel olarak verilmelidir
- Uygulama minimum Android API 21 (Android 5.0) gerektirir

## Güç Hesaplama Tablosu

| Amper | Faz Tipi | Güç Çıkışı |
|-------|----------|------------|
| 32A   | Üç Faz   | 22 kW      |
| 16A   | Üç Faz   | 11 kW      |
| 10A   | Üç Faz   | 7 kW       |
| 6A    | Üç Faz   | 3 kW       |
| 32A   | Tek Faz  | 7.4 kW     |
| 16A   | Tek Faz  | 3.7 kW     |
| 10A   | Tek Faz  | 2.3 kW     |
| 6A    | Tek Faz  | 1.3 kW     |

## Teknik Geliştirme Özeti

### Proje Gelişim Süreci
- Bluetooth bağlantı yönetimi ve kullanıcı izinleri iyileştirildi
- Kullanıcı deneyimini artırmak için komut gönderimi sonrası geri bildirim mekanizması geliştirildi
- Kod organizasyonu için yeniden kullanılabilir widget'lar oluşturuldu
- Router yapısı daha iyi yönetim için yeniden düzenlendi
- Mod değişikliklerinin ana sayfada görünürlüğü iyileştirildi
- State management optimizasyonları yapıldı

### Önemli Geliştirmeler
1. **Bluetooth İyileştirmeleri**
   - İzin yönetimi geliştirildi
   - Bağlantı durumu takibi iyileştirildi
   - Hata yönetimi güçlendirildi

2. **Kod Organizasyonu**
   - MVVM mimarisi güçlendirildi
   - Yeniden kullanılabilir bileşenler oluşturuldu
   - Router yapısı optimize edildi

3. **Kullanıcı Deneyimi**
   - Mod değişikliklerinde anlık UI güncellemeleri
   - Gelişmiş hata ve durum bildirimleri
   - Daha akıcı geçişler ve animasyonlar

### Gelecek Geliştirmeler İçin Öneriler
- Unit test coverage artırılabilir
- Performans optimizasyonları yapılabilir
- Bluetooth bağlantı stabilitesi daha da iyileştirilebilir
- Kullanıcı arayüzü tema desteği eklenebilir