---
description: 標準化 UI/UX 檢核流程 (Standard UI/UX Audit Flow)
---

# 標準化 UI/UX 檢核流程

此 Workflow 旨在系統化檢查專案代碼是否符合「日日 (Nichinichi)」設計系統的規範，特別著重於防止硬編碼樣式與違規特效。

## 1. 自動化靜態掃描 (Static Code Analysis)

使用 `grep` 快速掃描潛在違規。

- [ ] **檢查硬編碼顏色 (Hardcoded Colors)**
    - **規則**：UI Widget 中禁止使用 `Color(0x...)` 或 `Colors.xxx`。
    - **指令**：`grep -rE "Color\(0x|Colors\." lib/features`
    - **合格標準**：除 `core/theme` 外，應無輸出。

- [ ] **檢查陰影特效 (BoxShadow)**
    - **規則**：禁止使用 `BoxShadow` 或 `Elevation`（除非透過 Theme 定義的極微弱陰影）。
    - **指令**：`grep -r "BoxShadow" lib/features`
    - **合格標準**：確認所有陰影是否必要且符合「去投影化」原則。

- [ ] **檢查邏輯汙染 (Logic Pollution)**
    - **規則**：禁止在 Widget 中直接判斷 `Brightness`。
    - **指令**：`grep -r "Brightness\." lib/features`
    - **合格標準**：應無輸出。所有深色模式邏輯應封裝於 `ZenTheme`。

- [ ] **檢查字體使用 (Font Usage)**
    - **規則**：必須使用 `GoogleFonts`。
    - **指令**：`grep -r "TextStyle\(" lib/features`
    - **合格標準**：檢查是否誤用了原始 `TextStyle` 而非 `GoogleFonts`。

## 2. 人工視覺檢核 (Visual Review)
> 參照 Skill: `ui_design_system`

- [ ] **呼吸感檢查**：
    - 頁面邊距是否至少為 `16dp`？
    - 元件間距是否足夠（至少 `24dp`）？
- [ ] **無圖示檢查**：
    - 是否使用了非必要的 Icon？
    - 是否能用文字或顏色替代？
- [ ] **深色模式檢查**：
    - 切換至深色模式，確認文字對比度是否足夠（特別是引導字、次要文字）。
    - 是否有出現純黑 (`#000000`) 區塊？（應為深炭色 `#121212`）

## 3. 修復與提交 (Fix & Commit)

- [ ] **修復違規**：針對掃描出的問題進行修復。
- [ ] **提交**：使用 `chore(ui): ui audit fixes` 提交變更。
