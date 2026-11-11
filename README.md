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
git clone https://github.com/patcharakasitpk-svg/-auction-devpool69.git
cd -- -auction-devpool69
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
ทุก Pull Request จะรัน RuboCop, Brakeman และ test อัตโนมัติ (ดู `.github/workflows/ci.yml`)
