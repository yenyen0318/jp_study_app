---
description: 標準化新功能開發流程 (Standard Feature Development Flow)
---

# 標準化新功能開發流程

此 Workflow 旨在將專案中的 5 大核心 Skill 串聯為標準的一條龍開發作業，確保從規劃到部署的每一步都符合專案規範。

## 1. 核心規劃 (Content & Core Logic)
> 參照 Skill: `japanese_core_generator_expert`

- [ ] **確認教學目標**：明確定義此功能的 JLPT 等級 (N5-N1) 與學習目標。
- [ ] **生成內容計畫**：撰寫「繁體中文實作計畫」，包含範例資料結構 (JSON) 與邏輯細節。
- [ ] **確認規範**：確保所有日文範例遵循 `日文漢字 (振假名) — 繁體中文解釋` 格式。

## 2. 架構與狀態設計 (Architecture & State)
> 參照 Skill: `state_management_architect`

- [ ] **定義 State Model**：設計 Immutable 的狀態模型 (使用 Freezed)。
- [ ] **設計 Provider**：規劃 StateNotifier / Provider 結構，並確定依賴關係。
- [ ] **Repository 介面**：定義 Domain 層的介面與 Failure 類型。

## 3. UI/UX 設計 (Design System)
> 參照 Skill: `ui_design_system`

- [ ] **無圖示檢查**：確認介面設計未使用 Icon，僅使用文字與顏色。
- [ ] **色彩與間距**：確認使用 `color.bg.primary` 等語意化變數，以及 `24dp` 邊距。
- [ ] **元件規劃**：確認是否可重用現有 Zen 元件，或需新建 Widget。

## 4. 測試先行 (TDD - Test Driven Development)
> 參照 Skill: `testing_qa_specialist`

- [ ] **撰寫單元測試**：針對 Repository 與 Provider 撰寫測試，並確認測試失敗 (Red)。
- [ ] **撰寫 Widget 測試**：針對 UI 元件撰寫測試，包含 Golden Test 截圖驗證。

## 5. 實作與重構 (Implementation & Refactor)
- [ ] **實作核心邏輯**：撰寫程式碼以通過測試 (Green)。
- [ ] **實作 UI**：根據 Design System 實作畫面。
- [ ] **重構**：優化程式碼結構，補上完整的繁體中文註解。

## 6. 驗證與提交 (Verification & Commit)
> 參照 Skill: `git_automation_expert`

- [ ] **執行全套測試**：執行 `flutter test` 確保無回歸錯誤。
- [ ] **Git 提交**：
    - 確認分支乾淨。
    - 使用 `feat(scope): message` 格式提交。
    - 如有必要，更新 `CHANGELOG.md`。

---
**提示**：在每個步驟中，請務必先閱讀對應的 Skill 文件以獲取詳細指引。
