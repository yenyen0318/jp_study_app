---
description: 標準化問題修復流程 (Standard Issue Fixing Flow)
---

# 標準化問題修復流程

此 Workflow 旨在將專案中的 Skill 串聯為標準的修復與除錯作業，確保問題能被準確重現、修復並防止回歸。

## 1. 問題重現 (Reproduction)
> 參照 Skill: `testing_qa_specialist`

- [ ] **確認問題**：閱讀 Issue 描述或錯誤報告，確認預期行為與實際行為的差異。
- [ ] **建立重現測試**：
    - 若是邏輯錯誤：撰寫一個會失敗的單元測試 (Unit Test)。
    - 若是 UI/UX 錯誤：撰寫一個會失敗的 Widget Test 或 Integration Test。
    - **目標**：確保在修復前，有一個測試能準確捕捉到此錯誤 (Red)。

## 2. 原因分析 (Analysis)
> 參照 Skill: `technical_consultant_architect`

- [ ] **定位問題點**：使用 Debug 工具或日誌確認錯誤發生的確切位置。
- [ ] **分析影響範圍**：確認修復此問題是否會影響其他功能或狀態管理邏輯。
- [ ] **(可選) 諮詢架構師**：若涉及核心架構或狀態流向變更，請先諮詢 Technical Consultant。

## 3. 方案擬定 (Solution Planning)
> 參照 Skill: `state_management_architect`

- [ ] **設計修復方案**：
    - 若涉及 State 變更：確認是否符合 Immutable 原則與 Riverpod 規範。
    - 若涉及 UI 變更：確認是否符合 Nichinichi Design System。
- [ ] **確認測試策略**：除了重現測試外，是否需要補充其他邊界案例測試？

## 4. 測試驅動修復 (TDD Fix)
> 參照 Skill: `testing_qa_specialist`

- [ ] **實作修復**：修改程式碼以修復問題。
- [ ] **驗證測試**：執行步驟 1 建立的重現測試，確保測試通過 (Green)。
- [ ] **回歸測試**：執行相關模組的測試，確保無副作用。

## 5. UI/UX 驗收 (UI/UX Review)
> 參照 Skill: `ui_design_system` & `product_ux_strategist`

- [ ] **視覺檢查**：若涉及 UI 修改，確認是否符合設計規範 (色彩、間距、無圖示原則)。
- [ ] **體驗檢查**：確認修復後的互動流程是否順暢符合 Zen 的精神。

## 6. 提交與發布 (Commit & Release)
> 參照 Skill: `git_automation_expert`

- [ ] **執行全套測試**：執行 `flutter test` 確保整體穩定性。
- [ ] **Git 提交**：
    - 使用 `fix(scope): message` 格式提交。
    - 提及 Issue 編號 (例如 `fix(auth): resolve login timeout (#123)`).
- [ ] **(可選) 更新文件**：若修復涉及邏輯變更，同步更新相關註解或文檔。

---
**提示**：修復問題時，務必遵守「先測試，後修復」的原則，避免直接修改程式碼而無測試保護。
