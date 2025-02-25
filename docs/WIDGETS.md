# Widget Dokümantasyonu

## Genel Widget Yapısı

### 1. ModeInfoWidget
Şarj modunu gösteren widget.

```dart
ModeInfoWidget(
  screenWidth: double,
  screenHeight: double,
  fontSizeRatio: double,
)
```

**Özellikler:**
- Mod bilgisi gösterimi (Plug and play / Charge control)
- Responsive tasarım desteği
- Provider ile otomatik güncelleme

### 2. PowerInfoWidget
Güç bilgilerini gösteren widget.

```dart
PowerInfoWidget(
  screenWidth: double,
  screenHeight: double,
  selectedAmper: int,
  selectedPhase: String,
)
```

**Özellikler:**
- kW cinsinden güç gösterimi
- Amper ve faz değerine göre otomatik hesaplama
- Dinamik güncelleme

### 3. TemperatureWidget
Sıcaklık bilgisini gösteren widget.

```dart
TemperatureWidget(
  screenWidth: double,
  screenHeight: double,
  fontSizeRatio: double,
)
```

**Özellikler:**
- Celsius cinsinden sıcaklık gösterimi
- Responsive tasarım
- Anlık güncelleme

## Responsive Tasarım

### DeviceInfo Kullanımı
```dart
final deviceInfo = DeviceInfo();
deviceInfo.init(context);

double screenWidth = deviceInfo.screenWidth;
double screenHeight = deviceInfo.screenHeight;
```

### Ekran Oranları
- Font boyutu: `screenWidth * 0.045`
- Widget konumları: Ekran yüzdeleri ile hesaplama
- Padding ve margin değerleri: Dinamik hesaplama

## State Management

### Provider Entegrasyonu
```dart
Consumer<HomeViewModel>(
  builder: (context, viewModel, _) {
    return Text(
      viewModel.parsedDataList.isNotEmpty 
        ? viewModel.parsedDataList[1].toString() 
        : 'noData'.tr(),
    );
  },
)
```

### Lokalizasyon
```dart
Text('noData'.tr()) // Easy Localization kullanımı
```

## Widget Ağacı

```
HomePage
├── ModeInfoWidget
├── PowerInfoWidget
├── TemperatureWidget
└── ControlButtons
    ├── StartButton
    └── StopButton
```

## Özelleştirme

### Tema Desteği
- Renk paleti
- Font stilleri
- İkon setleri

### Animasyonlar
- Geçiş animasyonları
- Yükleme animasyonları
- Durum değişim animasyonları

## Best Practices

### 1. Widget Bölümleme
- Tek sorumluluk prensibi
- Yeniden kullanılabilirlik
- Kolay bakım

### 2. Performance
- `const` constructor kullanımı
- Gereksiz build'lerden kaçınma
- Hafıza optimizasyonu

### 3. Error Handling
- Null safety
- Hata durumları için placeholder
- Kullanıcı geri bildirimi

## Örnek Kullanım

```dart
Scaffold(
  body: Stack(
    children: [
      ModeInfoWidget(
        screenWidth: deviceInfo.screenWidth,
        screenHeight: deviceInfo.screenHeight,
        fontSizeRatio: deviceInfo.screenWidth * 0.045,
      ),
      PowerInfoWidget(
        screenWidth: deviceInfo.screenWidth,
        screenHeight: deviceInfo.screenHeight,
        selectedAmper: viewModel.selectedAmper,
        selectedPhase: viewModel.selectedPhase,
      ),
      TemperatureWidget(
        screenWidth: deviceInfo.screenWidth,
        screenHeight: deviceInfo.screenHeight,
        fontSizeRatio: deviceInfo.screenWidth * 0.045,
      ),
    ],
  ),
)
``` 