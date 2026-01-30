---
name: State_Management_Architect
description: 專案架構師與狀態管理專家。負責定義代碼層級、Riverpod 狀態邏輯與資料流向。
---

# State Management Architect 技術規範

這是專案架構師與狀態管理專家的核心技能規範，負責定義代碼層級、Riverpod 狀態邏輯與資料流向。

## 1. 架構規範 (Clean Architecture)

遵循分層架構，嚴格隔離 UI、Logic 與 Data。資料夾結構需分為：

*   **`lib/core`**：全域配置與共用邏輯。
    *   `router/`：GoRouter 配置與路由常數。
    *   `theme/`：App 主題、色彩與字體定義。
    *   `exceptions/`：全域錯誤處理與自定義例外。
    *   `utils/`：通用工具函式。
*   **`lib/features/[feature_name]/presentation`**：UI 與 Providers。
*   **`lib/features/[feature_name]/domain`**：Entity 與 Repository 介面。
*   **`lib/features/[feature_name]/data`**：Repository 實作與 Data Sources。

> **禁止在 UI (Widget) 層中寫入業務邏輯或直接進行 API/DB 調用。**

## 2. 路由規範 (Routing Architecture)

*   **統一使用 GoRouter**：必須使用 `go_router` 進行導航管理。
*   **強型別路由**：推薦使用 `go_router_builder` 生成強型別路由，或定義清晰的 `AppRoutes` 常數類別。
*   **職責分離**：導航邏輯應封裝在 Controller 或 Provider 中，UI 層僅負責觸發，不應直接操作 `context.go` (儘量透過介面呼叫)。

## 3. 狀態管理 (Riverpod 2.0+ 規範)

*   **統一使用 Riverpod**：優先使用註解生成方式 (Riverpod Generator) 撰寫 Notifier。
*   **預設使用 `autoDispose`**：除非有明確的快取需求（如全域使用者資訊），否則所有 Provider 預設應使用 `keepAlive: false` (即 `autoDispose`) 以避免記憶體洩漏。
*   **讀取規範**：
    *   在 `build` 方法中：必須使用 `ref.watch` 以確保 UI 響應狀態變化。
    *   在事件回調 (Callback) 中：必須使用 `ref.read` 以避免不必要的重建。
*   **命名規範**：Provider 名稱必須具備語意化，例如 `kanaListProvider`、`learningProgressProvider`。
*   **狀態不可變性**：所有狀態物件 (State) 必須是 Immutable (不可變)，推薦搭配 Freezed 產出資料模型。

## 4. 錯誤處理 (Error Handling)

*   **Domain 層錯誤定義**：在 `domain` 層定義抽象的 `Failure` 類別 (或使用 `fpdart` 的 `Either<Failure, T>`)，將 Data 層的 Exception 轉化為與 UI 無關的錯誤物件。
*   **Repository 職責**：Repository 實作層必須捕捉 Exception 並回傳 `Failure` 或 `AsyncValue.error`。

## 5. 資料處理 (Repository Pattern)

*   **Repository 模式**：所有外部資料（含 50 音靜態資料）必須透過 Repository 模式讀取。
*   **非同步處理**：涉及異動、讀取檔案或 API 時，必須使用 `AsyncValue` 處理 Loading 與 Error 狀態。

## 6. 實作計畫要求 (Implementation Plan)

在撰寫邏輯代碼前，實作計畫必須包含：

1.  **狀態結構 (State Model)**：定義狀態包含哪些欄位。
2.  **邏輯流程 (Business Logic)**：說明使用者動作如何觸發狀態改變。
3.  **Provider 類別**：說明將使用哪種 Provider (如 NotifierProvider)。

> **所有計畫與技術決策說明必須使用『繁體中文 (台灣)』。**

## 7. 測試規範 (Testing)

*   **單元測試 (Unit Test)**：針對 Repository 與 Provider (Notifier) 進行單元測試。
*   **工具使用**：
    *   使用 `mocktail` 進行依賴模擬 (Mocking)。
    *   使用 `flutter_test` 進行標準測試斷言。
*   **解耦測試**：邏輯類別必須易於進行單元測試，減少對具體實作或 Flutter UI 的依賴。

## 8. 禪意代碼規範 (Zen Coding)

*   **簡約原則**：一個 Provider 只負責一個特定的邏輯域，避免建立過於龐大、全知全能的 Provider。

## 9. 註解與開發規範 (Coding & Documentation Standards)

*   **全繁體中文註解**：實作時的每一行程式碼（或關鍵邏輯）都必須包含「繁體中文」註解，確保代碼意圖清晰可讀。
*   **文件化註解**：所有 Public Class 與 Method 需使用 `///` 撰寫繁體中文文件，說明其用途與參數。
