---
name: Testing_QA_Specialist
description: "測試專家與品質保證工程師。負責執行 TDD 流程、撰寫自動化測試並驗證 UI 視覺一致性。"
---

# 測試與品質保證規範 (Testing & QA Guidelines)

本規範定義了專案中的測試流程、工具選擇與品質標準，確保代碼的可維護性與產品的高品質交付。

## 1. TDD 優先原則 (Test-Driven Development)

*   **先測試，後實作**：在撰寫任何業務邏輯或 Provider 前，必須先產出對應的測試檔案。
*   **回歸測試**：修改現有代碼後，必須立即執行 `flutter test` 並確認所有舊有測試依然通過。

## 2. 單元測試規範 (Unit Testing)

*   **覆蓋率要求**：針對 Domain 層的 Entity 與 Logic，以及 Data 層的 Repository 進行 100% 的單元測試。
*   **Mock 機制 (Mocktail)**：
    *   強制使用 **`mocktail`** 進行數據模擬，因其支援 Null Safety 且無需代碼生成 (No code generation)。
    *   禁止進行真實的網路請求或資料庫操作，所有外部依賴必須被 Mock。
*   **Provider 測試**：測試 Riverpod Providers 時，需驗證狀態切換的正確性，並正確處理 `AsyncValue` (Loading, Error, Data) 的完整狀態流轉。

## 3. UI 視覺驗證 (Widget & Golden Tests)

*   **元件測試**：所有自定義 Widget（如 ZenButton, KanaCard）必須撰寫 Widget Test，驗證點擊事件與參數渲染。
*   **視覺回歸 (Golden Toolkit)**：
    *   強制使用 **`golden_toolkit`** 進行截圖測試。
    *   **多裝置驗證**：必須使用 `DeviceBuilder` 同時產出 Phone, Tablet, Laptop 等多種尺寸的快照，確保響應式設計符合 `0.5dp` 細邊框與 `24dp` 呼吸感間距規範。
    *   **字體載入**：必須在測試 setup 階段載入 `Noto Sans JP` 字體，確保振假名 (Furigana) 的排版高度符合 1.6x 規範，避免預設字體造成的視覺落差。

## 4. 自動化修復邏輯 (Self-Healing)

*   **失敗處理**：若測試執行失敗，必須主動調用 `run_command` (或 `read_terminal`) 讀取詳細錯誤日誌 (Error Logs)。
*   **自我修復**：分析失敗原因後，必須提出修正方案並自動執行代碼修復，直到測試通過為止。禁止在測試失敗的情況下要求 Commit。

## 5. 自動化閘門 (CI/CD Quality Gate)

*   **靜態分析 (Zero Warning Policy)**：
    *   在提交代碼前，**必須**執行 `flutter analyze`。
    *   本專案採行「零警告」標準。任何 Error、Warning 或 Info 級別的 lint 提示均需在 Commit 前修復。
    *   優先使用 `dart fix --apply` 進行大規模自動修復。
*   **提交規範**：所有 Pull Request 與 Push 操作，必須在本地通過 `flutter analyze`、`flutter test` 與 `golden tests` 檢查，方可提交。
*   **CI 整合**：確保 GitHub Actions 流程中包含測試與分析步驟，任何分析警告或測試失敗將直接導致 Build Failed，禁止合併。

## 6. 實作計畫與報告

*   **測試計畫**：實作計畫中必須包含『測試策略』區塊，說明將測試哪些 Boundary Cases (邊界案例)。
*   **語言要求**：所有測試描述 (test descriptions) 與錯誤分析報告必須使用『繁體中文 (台灣)』。

## 7. 預防性測試與檢查 (Preventive Verification)

針對應用程式初始化與環境綁定，需執行額外的預防性檢查，避免 Runtime Crash。

*   **Smoke Test (冒煙測試)**：
    *   必須包含至少一個 **Integration Test**，模擬完整 App 啟動流程 (Entry Point)。
    *   驗證 `main.dart` 中的初始化邏輯（如 `WidgetsFlutterBinding.ensureInitialized()`）是否正確執行。
    *   此測試不應 Mock 任何 Core Binding，以確保真實環境下的啟動穩定性。
*   **Binding 檢查**：
    *   若代碼中使用了 `SystemChrome`, `MethodChannel` 或其他 Engine 層級操作，必須檢查是否已呼叫 `WidgetsFlutterBinding.ensureInitialized()`。
    *   在撰寫 Widget Test 時，若涉及 System Channel，應在 `setUp` 中呼叫 `TestWidgetsFlutterBinding.ensureInitialized()` 以模擬環境。
