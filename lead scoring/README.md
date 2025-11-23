# Enterprise Lead Scoring Engine

A robust, metadata-driven Salesforce Lead Scoring solution designed for scalability and maintainability. This project demonstrates enterprise-level Apex patterns including **Trigger Frameworks**, **Batch Processing**, **Selector Patterns**, and **Metadata-Driven Architecture**.

## Key Features

### 1. Metadata-Driven Architecture
- **No Hardcoding**: Scoring rules are managed via **Custom Metadata Types** (`LeadScoringRule__mdt`), allowing admins to modify logic without code deployment.
- **Flexible Operations**: Supports dynamic comparison operations (`Equals`, `NotEquals`, `Contains`).

### 2. Real-Time & Batch Processing
- **Trigger Automation**: Automatically calculates scores on Lead creation and update.
- **Batch Processing**: Includes a Batch Apex class (`LeadScoringBatch`) to recalculate scores for millions of existing records when rules change.
- **Dynamic SOQL**: The batch class intelligently queries only the fields required by active rules to optimize heap size and query performance.

### 3. Enterprise Patterns & Testing
- **Trigger Handler Pattern**: Logic is decoupled from the Trigger for better separation of concerns.
- **Selector Pattern**: Uses a virtual `LeadScoringRuleSelector` to abstract database queries.
- **Mocking in Tests**: Achieves **100% logic coverage** by mocking Custom Metadata records in unit tests, overcoming the limitation of not being able to insert metadata during tests.

## 🛠 Technical Architecture

### Data Model
- **Lead**: Added `Score__c` field.
- **LeadScoringRule__mdt**:
    - `Field__c`: API Name of the field to check.
    - `Value__c`: Value to compare.
    - `Operation__c`: Operator (Equals, Contains, etc.).
    - `Score__c`: Points to assign.

### Class Structure
| Class | Description |
|-------|-------------|
| `LeadScoring` | Core domain logic for calculating scores. |
| `LeadTriggerHandler` | Orchestrates execution during Trigger events. |
| `LeadScoringBatch` | Handles bulk updates with dynamic query generation. |
| `LeadScoringRuleSelector` | Data access layer for Custom Metadata. |
| `LeadScoringTest` | Comprehensive unit tests with Mock Selector. |

## Getting Started

### 1. Deploy to Org
Deploy the source code to your Salesforce Developer Org or Scratch Org.
```bash
sfdx force:source:deploy -p force-app
```

### 2. Configure Rules
Navigate to **Setup > Custom Metadata Types > Lead Scoring Rule**.
Create records to define your scoring logic:
- **Example**: If `Industry` equals `Technology`, add `10` points.

### 3. Run Tests
Execute the included test suite to verify logic.
```bash
sfdx force:apex:test:run -l RunLocalTests -c
```

---
*This project was built to demonstrate advanced Apex capabilities and best practices.*
