---
description: 標準化程式碼重構流程 (Standard Code Refactoring Flow)
---

# 標準化程式碼重構流程

此 Workflow 旨在確保「日日」App 的代碼進化過程既安全又高品質。透過結合重構專家、架構師與測試專家，我們將「能動的代碼」轉換為「優雅的藝術品」。

## 1. 目標鎖定與風險評估 (Targeting & Risk Audit)
> 參照 Skill: `code_refactoring_maestro`, `technical_consultant_architect`

- [ ] **識別痛點**：明確指出當前代碼的效能瓶頸、硬幹邏輯或可讀性問題。
- [ ] **重構定位**：由 `Code_Refactoring_Maestro` 定義重構範圍（如：UI 層、狀態管理或資料層）。
- [ ] **技術諮詢**：由 `Technical_Consultant_Architect` 評估重構是否會影響現有架構，或是否存在過度設計的風險。
- [ ] **制定重構計畫**：撰寫實作計畫，明確標記影響範圍。

## 2. 測試防護網 (Safety Net - Testing)
> 參照 Skill: `testing_qa_specialist`

- [ ] **確保測試存在**：重構前，確認對應功能已有現成的單元測試或 Widget 測試。
- [ ] **建立基準 (Baseline)**：在動代碼前，先執行一次完整測試，確保當前代碼狀態是 Green。
- [ ] **補齊缺失測試**：若該部分缺乏測試，必須先補齊基礎測試後才能開始重構。

## 3. 執行重構：代碼守護者模式 (Execution: Code Guardian Mode)
> 參照 Skill: `code_refactoring_maestro`, `state_management_architect`

- [ ] **應用執行準則**：
    - [ ] **效能優化**：減少不必要的 Widget Rebuild，檢查 const 與 Consumer。
    - [ ] **資源清理**：確保 dispose 邏輯完整。
    - [ ] **Riverpod 最佳實踐**：優化 Provider 顆粒度，清除無效 watch。
- [ ] **消除硬幹邏輯**：
    - [ ] 抽離 Magic Numbers 至系統配置。
    - [ ] 審查硬編碼字串，確保其清晰且具備維護性。
- [ ] **命名與可讀性**：調整命名以符合「日文學習」語境，優化嵌套結構。

## 4. 靜態分析與二次審核 (Analysis & Peer Review)
- [ ] **Flutter Analyze**：執行 `flutter analyze`，確保重構後**零警告**。
- [ ] **自我審核**：對照 `Code_Refactoring_Maestro` 的執行準則，檢查是否達成「簡約與禪意」的目標。

## 5. 驗證與同步 (Verification & Sync)
> 參照 Skill: `git_automation_expert`

- [ ] **執行全套測試**：再次執行所有測試，確保重構未引發任何 Regressions。
- [ ] **Git 提交**：
    - 使用 `refactor(scope): message` 格式。
    - 在訊息中描述此次重構具體優化的部分（如：效能提升、可讀性改善）。

---
**提示**：在重構過程中，切記「小步快走」，避免一次進行過大範圍的變動。
