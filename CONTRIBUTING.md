# แนวทางการทำงานร่วมกัน (Team Workflow)

## Branch
- `main` — โค้ดที่พร้อมใช้งาน **ห้าม push ตรง** ต้องผ่าน Pull Request (PR) เท่านั้น
- แตก branch จาก `main` ตามรูปแบบ:
  - `feature/<issue-number>-short-name` เช่น `feature/12-place-bid`
  - `fix/<issue-number>-short-name`
  - `chore/<short-name>` (config, dependency, docs)

## ขั้นตอนทำงาน 1 งาน
1. เลือก issue จาก **Issues → Milestones** (milestone ของวันนี้) แล้ว assign ตัวเอง และเปลี่ยน label เป็น `status: doing`
2. `git checkout main && git pull`
3. `git checkout -b feature/12-place-bid`
4. เขียนโค้ด + test → `bin/rails test` และ `bin/rubocop` ต้องผ่าน
5. Commit (ดูรูปแบบด้านล่าง) แล้ว `git push -u origin feature/12-place-bid`
6. เปิด PR ไปที่ `main` ใส่ `Closes #12` ในคำอธิบาย → เปลี่ยน label เป็น `status: review`
7. ให้เพื่อนร่วมทีมอย่างน้อย 1 คน review → CI ผ่าน → Merge (issue ปิดอัตโนมัติ)

## Commit message
```
<type>: <สรุปสั้น ๆ>

type = feat | fix | chore | docs | test | refactor
```
ตัวอย่าง: `feat: add bid validation for minimum increment`

## Milestone = Sprint ละ 1 วัน
- แต่ละ milestone คือเป้าหมายของ 1 วันทำงาน ดูภาพรวมที่ [docs/ROADMAP.md](docs/ROADMAP.md)
- งานที่ไม่เสร็จในวันนั้น ให้ย้ายไป milestone ถัดไป

## Labels
| กลุ่ม | ค่า |
|---|---|
| `type:` | feature, bug, chore, docs |
| `priority:` | high, medium, low |
| `area:` | backend, frontend, database, devops |
| `status:` | todo, doing, review, done |
