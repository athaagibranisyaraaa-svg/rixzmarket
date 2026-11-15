# RIXZ HOSTING — Vercel Root Project

Project root: `index.html`, `index.js`, `style.css`, `config.js`. Deploy dengan Vercel preset Other.

## Fitur
- Login/registrasi username + password melalui Supabase Auth.
- Role owner ditetapkan manual di database (bukan melalui registrasi publik).
- Dashboard member: DigitalOcean, Linode, Pterodactyl.
- Owner dapat mengatur URL deposit/top-up, URL tujuan provider, deskripsi layanan, maintenance.
- UI menyiapkan kapasitas konfigurasi: 10 token DigitalOcean, 5 token Linode, 5 endpoint/panel Pterodactyl.
- Logo yang diberikan dipasang di `assets/rixz-hosting-logo.png`.
- Support WhatsApp 085791115059, Telegram @cocovrix.

## Setup
1. Buat project Supabase.
2. Authentication > Providers > Email: aktifkan Email provider dan nonaktifkan Confirm email agar login username/password dapat langsung dipakai. Username dipetakan ke email internal `username@users.rixz-hosting.invalid`.
3. Jalankan `supabase-schema.sql` di Supabase SQL Editor.
4. Isi `config.js` dengan Project URL dan anon/public key. Jangan pernah menaruh service_role key di browser.
5. Di Vercel Environment Variables isi `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`.
6. Import repository ke Vercel, Framework Preset Other, Root Directory `./`, Build Command kosong, Output Directory `.`.
7. Registrasikan akun owner melalui halaman registrasi, lalu ubah role di SQL Editor: `update public.profiles set role='owner' where username='USERNAME_OWNER';` Logout/login kembali.

## Slot API provider (server-side)
Kapasitas yang diminta disiapkan pada `.env.example`:
- `DIGITALOCEAN_API_TOKEN_1` sampai `_10`
- `LINODE_API_TOKEN_1` sampai `_5`
- `PTERODACTYL_URL_1` sampai `_5` dan `PTERODACTYL_API_KEY_1` sampai `_5`

Simpan rahasia tersebut di Vercel Environment Variables, bukan `config.js`, HTML, atau browser storage. UI saat ini mengelola URL deposit dan URL tujuan provider. Ini **belum** menjalankan provisioning otomatis atau menguji token API. Untuk otomatisasi pembelian, masih perlu dibuat backend order/provisioning, pemilihan slot provider, validasi kuota, callback pembayaran, dan audit log.

## Deposit
Owner mengisi `Deposit / top-up URL` pada Owner Console. Integrasi pembayaran belum terhubung; URL tersebut hanya disiapkan sebagai konfigurasi tujuan deposit.

## Security
- Jangan izinkan role owner dari form registrasi publik.
- Gunakan password kuat dan aktifkan proteksi rate limit/CAPTCHA sebelum produksi.
- Simpan semua token API provider dan service role key sebagai environment variable server-side.
- Terapkan verifikasi pembayaran sebelum membuat VPS/server.
- Pastikan endpoint provisioning menolak order ketika maintenance aktif.
