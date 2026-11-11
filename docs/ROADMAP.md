# Roadmap — Auction Project (ร่างเบื้องต้น)

> Sprint ละ 1 วันทำงาน (เว้นเสาร์–อาทิตย์) · ปรับแก้วันที่/ขอบเขตได้ที่ GitHub → Issues → Milestones

| Milestone | วันที่ | เป้าหมาย |
|---|---|---|
| M01 – Project Setup | 2026-11-11 | Rails app + PostgreSQL รันได้ทุกเครื่อง, CI ผ่าน, ทีมเข้าถึง repo |
| M02 – User Authentication | 2026-11-12 | สมัครสมาชิก / login / logout, role (user, admin) |
| M03 – Auction Items | 2026-11-13 | Model `Item` / `Auction` + CRUD, ราคาเริ่มต้น, เวลาเริ่ม–จบ |
| M04 – Listing & Images | 2026-11-16 | หน้ารายการประมูล, ค้นหา/กรอง, อัปโหลดรูป (Active Storage) |
| M05 – Bidding Core | 2026-11-17 | Model `Bid`, validation ราคาขั้นต่ำ, กัน race condition (row lock) |
| M06 – Real-time Bidding | 2026-11-18 | อัปเดตราคาแบบ real-time ด้วย Turbo Streams / Action Cable |
| M07 – Auction Closing | 2026-11-19 | ปิดประมูลอัตโนมัติ (Solid Queue), ประกาศผู้ชนะ, แจ้งเตือน |
| M08 – Dashboard & Profile | 2026-11-20 | ประวัติการ bid, รายการที่ชนะ, หน้า admin |
| M09 – Testing & Bug Fix | 2026-11-23 | เพิ่ม test coverage, แก้บั๊ก, ปรับ UI |
| M10 – Deploy & Demo | 2026-11-24 | Deploy (Kamal / Render), seed data, สาธิต |

## Data model (ร่าง)
```
User (email, password_digest, name, role)
  └─< Auction (title, description, starting_price, current_price, starts_at, ends_at, status, seller_id, winner_id)
        └─< Bid (amount, user_id, auction_id, created_at)
```
