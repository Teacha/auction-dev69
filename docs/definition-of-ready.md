# Definition of Ready (DoR)

Issue จะได้ label `status::ready` และถูกดึงเข้า Sprint ได้เมื่อผ่านทุกข้อ:

- [ ] เขียนเป็น user story: **ในฐานะ** ... **ฉันต้องการ** ... **เพื่อ** ...
- [ ] มี **Acceptance Criteria** แบบ Given / When / Then ที่ทดสอบได้ ครอบคลุม happy path, error และ **boundary**
- [ ] ขนาดเล็กพอทำเสร็จใน 1 Sprint (1 วัน) — ถ้าใหญ่กว่า ให้แตก issue
- [ ] ไม่มี dependency ที่ยังค้าง หรือระบุไว้ชัดแล้ว (ลิงก์ issue ที่ต้องเสร็จก่อน)
- [ ] มี UI reference (artboard ใน [Design canvas](https://claude.ai/artifact/QQMiqYfRigdsJ1rj4E4jLn)) ถ้ามีหน้าจอ
- [ ] ระบุข้อมูล/ฟิลด์ และกฎ validation ครบ
- [ ] ใส่ label ครบ: `type::`, `priority::`, `area::`, `roadmap::` และผูก milestone
- [ ] ทีมเข้าใจตรงกันและประมาณขนาดแล้ว (Sprint Planning / Refinement)
