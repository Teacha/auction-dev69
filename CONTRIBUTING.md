# Contributing

## Branch strategy

- `main` — โค้ดที่พร้อม deploy เสมอ **ห้าม push ตรง** ทุกการเปลี่ยนแปลงต้องผ่าน Pull Request (PR)
- สร้าง branch จาก `main` ล่าสุด ตั้งชื่อตามประเภทงานและเลข issue:

| Prefix | ใช้เมื่อ | ตัวอย่าง |
|---|---|---|
| `feature/*` | ฟีเจอร์ใหม่ | `feature/12-seller-create-product` |
| `fix/*` | แก้ bug | `fix/34-image-limit-off-by-one` |
| `chore/*` | งาน infra, config, dependency, docs | `chore/groundwork` |

- Branch ควรมีอายุสั้น (≤ 1 Sprint = 1 วัน) ถ้างานใหญ่ให้แตก issue ย่อย
- ลบ branch หลัง merge

## Commit convention — [Conventional Commits](https://www.conventionalcommits.org/)

```
<type>(<scope>): <สรุปสั้น ๆ>

[รายละเอียด — ทำไมถึงเปลี่ยน]

Refs #<issue>
```

- `type`: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `ci`, `perf`, `build`
- `scope` (ไม่บังคับ): `seller`, `admin`, `auction`, `auth`, `infra`
- ตัวอย่าง: `feat(seller): validate starting price 1–20,000 baht`
- Breaking change: ใส่ `!` หลัง type หรือ `BREAKING CHANGE:` ใน footer

## ขั้นตอน Pull Request

1. หยิบ issue ที่มี `status::ready` (ผ่าน [Definition of Ready](docs/definition-of-ready.md)) แล้ว assign ตัวเอง เปลี่ยน label เป็น `status::in-progress`
2. สร้าง branch → เขียน test + code → รัน `bin/ci` ให้ผ่านในเครื่อง
3. เปิด PR เข้า `main` ตาม template — ใส่ `Closes #<issue>`, milestone, label
4. เปลี่ยน label issue เป็น `status::review`
5. CI (lint, security, test) ต้องเขียวทั้งหมด
6. ได้ **approval อย่างน้อย 1 คน** (ห้าม approve PR ตัวเอง)
7. ผู้เปิด PR เป็นคน merge — ใช้ **Squash and merge** โดยชื่อ commit เป็น Conventional Commit

## Code review

ผู้ review ตรวจตาม [Definition of Done](docs/definition-of-done.md) และ:

- ทำตาม Acceptance Criteria ครบทุกข้อ รวม boundary case
- มี test ครอบคลุม logic ใหม่ และ test มีความหมาย (ไม่ใช่แค่ให้ coverage ขึ้น)
- ไม่มี secret, token, password ใน code หรือ log
- ทำตาม [coding standard](docs/coding-standard.md): logic อยู่ใน model/service ไม่ใช่ view/controller
- Migration ย้อนกลับได้ และมี index/constraint ที่จำเป็น

แนวทาง comment: ใช้ prefix `nit:` (ไม่บังคับแก้), `question:`, `blocker:` (ต้องแก้ก่อน merge) — review โค้ด ไม่ใช่คน

## Labels

GitHub ไม่บังคับ scoped label เหมือน GitLab **ให้ใส่ได้ 1 label ต่อ 1 scope** (เช่น มี `priority::high` แล้วห้ามมี `priority::low`)

| Scope | ค่า | ความหมาย |
|---|---|---|
| `type::` | feature, bug, chore, docs, spike | ประเภทงาน |
| `priority::` | high, medium, low | ความสำคัญ |
| `status::` | ready, in-progress, review, blocked | สถานะใน Sprint |
| `area::` | seller, admin, auction, infra | ส่วนของระบบ |
| `roadmap::` | committed, tentative | committed = ทำแน่ใน milestone นี้, tentative = อาจเปลี่ยนหลัง Sprint Review |

## Milestones

M0–M3 คือเส้นทางสู่ Release v0.1 Beta (committed), M4 ขึ้นไปเป็น tentative และ **ลำดับปรับใหม่ทุก Sprint Review**
