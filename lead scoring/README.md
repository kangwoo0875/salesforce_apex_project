# Enterprise Lead Scoring Engine

Salesforceのリードスコアリング機能を拡張したプロジェクトです。スケーラビリティとメンテナンス性を重視して設計しました。Trigger FrameworkやBatch処理、Selectorパターン、メタデータ駆動アーキテクチャなど、エンタープライズ開発でよく使われる実践的なパターンを取り入れています。

## Key Features

### 1. Metadata-Driven Architecture
- **No Hardcoding**: スコアリングのルールは *LeadScoringRule__mdt* (カスタムメタデータ) で管理するようにしました。これで、コードを修正しなくても管理者が自由にロジックを変更できます。
- **Flexible Operations**: *Equals* や *Contains* など、状況に合わせて柔軟な比較ができるようにしています。

### 2. Real-Time & Batch Processing
- **Trigger Automation**: リードが作成されたり更新されたりしたタイミングで、自動的にスコアを計算します。
- **Batch Processing**: ルールが変わった時に備えて、過去のデータを一括で再計算できるバッチクラス *LeadScoringBatch* も用意しました。
- **Dynamic SOQL**: バッチ処理では、必要なフィールドだけを動的にクエリするようにして、パフォーマンスを最適化しています。

### 3. Enterprise Patterns & Testing
- **Trigger Handler Pattern**: ロジックをTriggerから切り離して、コードがごちゃごちゃにならないように整理しました。
- **Selector Pattern**: データベースへのクエリ部分を *LeadScoringRuleSelector* として独立させています。
- **Mocking in Tests**: テストコードでは、実際にメタデータを登録する代わりにモック（ダミーデータ）を使うことで、ロジックのテストカバレッジ100%を達成しました。

## Technical Architecture

### Data Model
- **Lead**: *Score__c* というフィールドを追加しました。
- **LeadScoringRule__mdt**:
    - *Field__c*: チェックする項目のAPI名
    - *Value__c*: 比較する値
    - *Operation__c*: 比較方法 (Equals, Containsなど)
    - *Score__c*: 加算するスコア

### Class Structure
| Class | Description |
|-------|-------------|
| LeadScoring | スコア計算のメインロジックを担当します。 |
| LeadTriggerHandler | Triggerが動いた時の処理を制御します。 |
| LeadScoringBatch | 大量のデータを一括更新するためのバッチ処理です。 |
| LeadScoringRuleSelector | カスタムメタデータへのアクセスを担当します。 |
| LeadScoringTest | テストクラスです。モックを使って効率的にテストします。 |

## Getting Started

### 1. Deploy to Org
ソースコードをSalesforce組織にデプロイします。
```bash
sfdx force:source:deploy -p force-app
```

### 2. Configure Rules
**Setup > Custom Metadata Types > Lead Scoring Rule** に移動して、ルールを作ってみてください。
- 例: *Industry* が *Technology* だったら、*10* ポイント追加する、など。

### 3. Run Tests
テストを実行して、ロジックが正しく動くか確認できます。
```bash
sfdx force:apex:test:run -l RunLocalTests -c
```

---
*このプロジェクトは、Apexの応用的な使い方とベストプラクティスをデモするために作りました。*
