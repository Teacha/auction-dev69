# Auction Project — devpool69

ระบบประมูลออนไลน์ด้วย **Ruby on Rails 8.1** + **PostgreSQL 17** + Hotwire (Turbo/Stimulus) + Tailwind CSS

- แผนงานและ milestone: [docs/ROADMAP.md](docs/ROADMAP.md)
- วิธีทำงานร่วมกัน (branch, PR, label): [CONTRIBUTING.md](CONTRIBUTING.md)

## เริ่มต้นใช้งาน (macOS)

### 1. ติดตั้งเครื่องมือ (ครั้งแรกครั้งเดียว)
```bash
# Ruby (ใช้ mise, rbenv หรือ asdf ก็ได้ — เวอร์ชันอยู่ใน .ruby-version)
brew install mise && mise install ruby@3.4.12

# PostgreSQL
brew install postgresql@17
brew services start postgresql@17
echo 'export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"' >> ~/.zshrc
```

### 2. Clone และ setup
```bash
git clone https://github.com/carbonformevent-stack/auction-dev69.git
cd auction-dev69
code .                      # เปิดใน VSCode → กด Install ส่วนขยายที่แนะนำ
```
ขอไฟล์ `config/master.key` จากหัวหน้าทีม (ส่งทางช่องทางส่วนตัว **ห้าม commit**) แล้ววางไว้ที่ `config/master.key`

```bash
bin/setup                   # bundle install + สร้างฐานข้อมูล + รันเซิร์ฟเวอร์
```

### 3. รันประจำวัน
```bash
bin/dev                     # เปิด http://localhost:3000
bin/rails test              # รัน test
bin/rubocop                 # ตรวจ code style
```

## CI
ทุก Pull Request จะรัน 3 job อัตโนมัติ (ดู `.github/workflows/ci.yml`):
- **lint** — RuboCop
- **security** — Brakeman, bundler-audit, importmap audit
- **test** — test บน PostgreSQL 17

## Deploy บน Railway
Railway build จาก `Dockerfile` ตามค่าใน `railway.json` (health check ที่ `/up`)
ทุกครั้งที่ start server จะรัน `bin/rails db:prepare` อัตโนมัติ ซึ่งสร้าง/migrate ทั้ง primary, cache, queue, cable

### ตั้งค่าครั้งแรก (ใน Railway dashboard)
1. **New Project → Deploy from GitHub repo** → `carbonformevent-stack/auction-dev69` branch `main`
2. ใน project เดียวกัน: **+ New → Database → PostgreSQL** และ **+ New → Bucket**
3. ตั้ง Variables ของ web service ตามตารางด้านล่าง
4. **Settings → Networking → Generate Domain**
5. **Settings → Deploy → เปิด "Wait for CI"** เพื่อ deploy เฉพาะ commit ที่ CI ผ่าน

### Environment variables
| ตัวแปร | ค่า | หมายเหตุ |
|---|---|---|
| `DATABASE_URL` | `${{Postgres.DATABASE_URL}}` | reference variable — cache/queue/cable ใช้ server เดียวกัน ชื่อ DB ต่อท้าย `_cache`, `_queue`, `_cable` |
| `RAILS_MASTER_KEY` | เนื้อหาไฟล์ `config/master.key` | **ห้าม commit** |
| `SOLID_QUEUE_IN_PUMA` | `true` | รัน background job ใน process เดียวกับ web |
| `S3_BUCKET` | `${{Bucket.BUCKET}}` | Active Storage |
| `S3_ACCESS_KEY_ID` | `${{Bucket.ACCESS_KEY_ID}}` | |
| `S3_SECRET_ACCESS_KEY` | `${{Bucket.SECRET_ACCESS_KEY}}` | |
| `S3_REGION` | `${{Bucket.REGION}}` | |
| `S3_ENDPOINT` | `${{Bucket.ENDPOINT}}` | |
| `APP_HOST` | custom domain (ถ้ามี) | `RAILWAY_PUBLIC_DOMAIN` ถูกอนุญาตอัตโนมัติ |

> ชื่อ service (`Postgres`, `Bucket`) ใน `${{...}}` ต้องตรงกับชื่อใน Railway project
> ถ้าใช้ Cloudflare R2 / AWS S3 แทน ให้ใส่ค่า `S3_*` ตรง ๆ
