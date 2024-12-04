# MacUnlockExample

**MacUnlockExample**, bir macOS uygulamasının ekran kilidini açma ve kontrol işlemleriyle ilgili temel özellikleri gösteren bir projedir. Proje, kullanıcı etkileşimlerini azaltmak için `LSUIElement` anahtarını kullanarak dock simgesini gizleyen bir arka plan uygulaması oluşturmayı içerir.

---

## Özellikler

- macOS cihazlarının ekran kilidini açma işlemlerini gösterir.
- Dock simgesini gizlemek için arka plan uygulama modu.
- Uygulama gizli çalışacak şekilde optimize edilmiştir.

---

## Kurulum

1. **Projeyi İndirin**  
   Projeyi bu depodan indirip Xcode ile açın.

2. **Info.plist Güncellemesi**  
   Uygulamanın dock simgesini gizlemek için, `Info.plist` dosyasına aşağıdaki anahtarı ekleyin:

   ```xml
   <key>LSUIElement</key>
   <string>1</string>
