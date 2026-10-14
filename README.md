# RuangKelasku

Clone Google Classroom untuk UTS mata kuliah Pemrograman Aplikasi Bergerak.

| Nama | NIM |
| --- | --- |
| Haikal Ahmad El Salman | _(isi NIM)_ |

## Struktur

| Folder | Isi |
| --- | --- |
| `backend/` | Laravel REST API + MySQL (Laragon) |
| `mobile/` | Flutter untuk Android dan Chrome |
| `docs/` | Product brief, ERD, spesifikasi API, arsitektur, desain |

## Menjalankan

Prasyarat: Laragon (PHP 8.3+, MySQL), Composer, Flutter stabil.

### Backend

```bash
cd backend
composer install
cp .env.example .env
php artisan key:generate
# Buat database `ruangkelasku` di MySQL Laragon
php artisan migrate --seed
php artisan storage:link
php artisan serve --host=0.0.0.0 --port=8000
php artisan schedule:work   # terminal terpisah, untuk posting terjadwal
```

### Mobile

```bash
cd mobile
flutter pub get
dart run build_runner build -d
flutter run -d chrome          # API di localhost:8000
flutter run -d emulator-5554   # API di 10.0.2.2:8000
```
