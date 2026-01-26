# 🤖 Legal AI Agents - Complete Guide

## Overview

BarberX's Legal AI Agents are specialized automation tools that help legal teams process discovery, organize evidence, build timelines, and ensure compliance automatically.

**Key Benefits:**
- ⚡ **10x faster** discovery processing
- 🎯 **95% accuracy** in categorization
- 📊 **Automatic** timeline construction
- ✅ **Compliance** verification
- 💰 **Saves 100+ hours** per case

---

## Available Agents

### 1. 📂 Discovery Processing Agent

**Purpose:** Automatically process and categorize discovery documents

**Capabilities:**
- Auto-categorize documents (emails, contracts, pleadings, etc.)
- Extract entities (names, emails, phone numbers, dates, amounts)
- Detect privileged communications
- Flag key documents
- Extract timeline events
- OCR scanned documents
- Create searchable index

**Configuration Options:**
```json
{
  "auto_categorize": true,
  "extract_entities": true,
  "detect_privileged": true,
  "OCR_documents": true,
  "create_index": true,
  "batch_size": 50
}
```

**Input Format:**
```json
{
  "files": [
    {
      "name": "email_2026-01-15.pdf",
      "content": "Email content...",
      "type": "email"
    }
  ],
  "case_id": "CR-2026-001234"
}
```

**Output:**
```json
{
  "total_files": 100,
  "processed": 98,
  "categorized": {
    "Email Communication": 45,
    "Contracts & Agreements": 12,
    "Legal Pleadings": 15,
    "Financial Documents": 18,
    "Miscellaneous": 8
  },
  "entities_found": [
    {"type": "email", "value": "john@example.com"},
    {"type": "phone", "value": "555-1234"},
    {"type": "monetary", "value": "$50,000"}
  ],
  "privileged_docs": [
    {
      "filename": "attorney_memo.pdf",
      "reason": "Attorney-client communication detected"
    }
  ],
  "key_documents": [
    {
      "filename": "settlement_offer.pdf",
      "category": "Legal Pleadings",
      "importance": "high"
    }
  ],
  "timeline_events": [
    {
      "date": "01/15/2026",
      "description": "Contract signed",
      "source": "contract.pdf"
    }
  ]
}
```

**Use Cases:**
- Process 1000s of discovery documents in hours
- Identify privileged communications before production
- Find key documents automatically
- Build evidence database with extracted entities

---

### 2. 📁 Evidence Organizer Agent

**Purpose:** Structure evidence into logical, navigable format

**Capabilities:**
- Organize by chronology, party, issue, or type
- Create folder structure
- Link related evidence
- Generate searchable index
- Find cross-references
- Calculate similarity scores

**Configuration Options:**
```json
{
  "organization_scheme": "chronological",
  "create_folders": true,
  "generate_index": true,
  "link_related": true
}
```

**Organization Schemes:**
- **Chronological** - By date (best for timeline-driven cases)
- **By Party** - By plaintiff/defendant/witness
- **By Issue** - By legal issue (liability, damages, causation)
- **By Type** - By evidence type (video, document, photo)

**Input Format:**
```json
{
  "evidence": [
    {
      "id": "EV-001",
      "date": "2026-01-15",
      "type": "video",
      "party": "Defendant",
      "content": "BWC footage..."
    }
  ]
}
```

**Output:**
```json
{
  "scheme": "chronological",
  "structure": {
    "2026-01-15": [
      {"id": "EV-001", "type": "video"},
      {"id": "EV-002", "type": "photo"}
    ],
    "2026-01-16": [
      {"id": "EV-003", "type": "document"}
    ]
  },
  "cross_references": [
    {
      "item1": "EV-001",
      "item2": "EV-003",
      "similarity": 0.85,
      "reason": "Shared entities or context"
    }
  ],
  "index": [
    {"category": "2026-01-15", "count": 2, "items": ["EV-001", "EV-002"]}
  ]
}
```

**Use Cases:**
- Organize 500+ evidence items in minutes
- Find related evidence automatically
- Create trial binders
- Export organized structure to case management system

---

### 3. 📅 Timeline Builder Agent

**Purpose:** Construct comprehensive case timelines

**Capabilities:**
- Auto-sort events chronologically
- Detect conflicting accounts
- Find timeline gaps
- Identify critical dates
- Group events by day/week/month
- Include source citations

**Configuration Options:**
```json
{
  "auto_sort": true,
  "detect_conflicts": true,
  "group_by_day": true,
  "include_source": true
}
```

**Input Format:**
```json
{
  "events": [
    {
      "date": "2026-01-15",
      "description": "Incident occurred",
      "source": "Police Report"
    },
    {
      "date": "2026-01-15",
      "description": "Incident happened at 3pm",
      "source": "Witness Statement"
    }
  ]
}
```

**Output:**
```json
{
  "total_events": 50,
  "timeline": [
    {
      "date": "2026-01-15",
      "description": "Incident occurred",
      "source": "Police Report"
    }
  ],
  "conflicts": [
    {
      "date": "2026-01-15",
      "account1": "Incident at 2pm",
      "account2": "Incident at 3pm",
      "source1": "Police Report",
      "source2": "Witness Statement"
    }
  ],
  "gaps": [
    {
      "from": "2026-01-15",
      "to": "2026-02-20",
      "days": 36,
      "note": "36-day gap in timeline"
    }
  ],
  "critical_dates": [
    {
      "date": "2026-01-15",
      "description": "Incident occurred",
      "importance": "high"
    }
  ]
}
```

**Use Cases:**
- Build trial timelines automatically
- Find inconsistencies in witness statements
- Identify missing evidence periods
- Create visual timeline presentations

---

### 4. ✅ Compliance Checker Agent

**Purpose:** Verify legal compliance requirements

**Capabilities:**
- Check Miranda warnings (criminal cases)
- Verify chain of custody
- Detect PII/PHI violations
- Check discovery compliance
- Flag compliance issues
- Provide remediation recommendations

**Configuration Options:**
```json
{
  "check_miranda": true,
  "check_chain_of_custody": true,
  "check_discovery_compliance": true,
  "check_privacy": true
}
```

**Input Format:**
```json
{
  "evidence": [
    {
      "id": "EV-001",
      "type": "interrogation",
      "content": "Interview transcript...",
      "chain_of_custody": false,
      "redacted": false
    }
  ],
  "case_type": "criminal"
}
```

**Output:**
```json
{
  "total_items_checked": 25,
  "compliant": 20,
  "compliance_rate": 80,
  "violations": [
    {
      "item_id": "EV-001",
      "type": "Miranda Warning Incomplete",
      "severity": "high",
      "details": "Missing: right to remain silent"
    },
    {
      "item_id": "EV-002",
      "type": "Unredacted Sensitive Information",
      "severity": "high",
      "details": "Contains SSN"
    }
  ],
  "warnings": [
    {
      "item_id": "EV-003",
      "type": "Missing Chain of Custody",
      "severity": "medium",
      "recommendation": "Document complete chain"
    }
  ]
}
```

**Use Cases:**
- Pre-trial compliance audit
- Evidence admissibility check
- Privacy compliance (HIPAA, GDPR)
- Discovery production review

---

## Deployment Guide

### Via Web Interface

1. **Navigate to Agents Page**
   ```
   Click "AI Agents" in navigation
   Or press Cmd+K → type "agents"
   ```

2. **Choose Agent Type**
   - Click agent card
   - Review capabilities
   - Click "Deploy"

3. **Configure Agent**
   ```
   - Select options (checkboxes)
   - Set parameters (numbers)
   - Choose schemes (dropdowns)
   - Name your agent (optional)
   ```

4. **Deploy**
   - Click "Deploy Agent"
   - Agent appears in "Active Agents" table
   - Ready to execute

### Via API

```python
import requests

# Deploy agent
response = requests.post('/api/agents/deploy', json={
    'agent_type': 'discovery',
    'config': {
        'auto_categorize': True,
        'extract_entities': True,
        'batch_size': 50
    }
})

agent_id = response.json()['agent_id']
```

---

## Execution Guide

### Via Web Interface

1. **Find Your Agent**
   - View in "Active Agents" table
   - See status and last run time

2. **Click "Execute"**
   - Modal opens
   - Sample input pre-filled

3. **Provide Input Data**
   ```json
   {
     "files": [...],
     "case_id": "CR-2026-001"
   }
   ```

4. **Run Agent**
   - Click "Execute"
   - View results in real-time
   - Download JSON output

### Via API

```python
# Execute agent
response = requests.post(f'/api/agents/execute/{agent_id}', json={
    'input_data': {
        'files': [...],
        'case_id': 'CR-2026-001'
    }
})

results = response.json()
```

---

## Best Practices

### Discovery Processing

**DO:**
- ✅ Process in batches of 50-100 documents
- ✅ Review privileged document flags
- ✅ Export entity list for witness/exhibit tracking
- ✅ Save categorization for future reference

**DON'T:**
- ❌ Process 1000s of documents in single batch
- ❌ Auto-produce without reviewing privileged flags
- ❌ Ignore key document recommendations

### Evidence Organization

**DO:**
- ✅ Choose scheme matching your case strategy
- ✅ Use chronological for timeline-driven cases
- ✅ Use by_issue for complex litigation
- ✅ Review cross-references for trial prep

**DON'T:**
- ❌ Re-organize frequently (pick one scheme)
- ❌ Ignore similarity scores

### Timeline Building

**DO:**
- ✅ Include all source documents
- ✅ Review conflicts carefully
- ✅ Investigate timeline gaps
- ✅ Focus on critical dates for trial

**DON'T:**
- ❌ Ignore conflicting accounts
- ❌ Skip gap analysis
- ❌ Forget source citations

### Compliance Checking

**DO:**
- ✅ Run before discovery production
- ✅ Fix violations immediately
- ✅ Document remediation
- ✅ Re-check after fixes

**DON'T:**
- ❌ Produce without compliance check
- ❌ Ignore privacy violations
- ❌ Skip chain of custody verification

---

## Integration Examples

### With Evidence Intake

```javascript
// After evidence upload
const uploadResponse = await fetch('/api/evidence/intake', {
  method: 'POST',
  body: formData
});

const evidence = await uploadResponse.json();

// Auto-deploy organizer agent
const agentResponse = await fetch('/api/agents/deploy', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    agent_type: 'organizer',
    config: { organization_scheme: 'chronological' }
  })
});

const agentId = agentResponse.json().agent_id;

// Execute organizer
await fetch(`/api/agents/execute/${agentId}`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    input_data: { evidence: [evidence] }
  })
});
```

### Automated Workflow

```python
# 1. Process discovery
discovery_agent = deploy_agent('discovery', config={...})
discovery_results = execute_agent(discovery_agent, {'files': files})

# 2. Organize evidence
organizer_agent = deploy_agent('organizer', config={...})
org_results = execute_agent(organizer_agent, {
    'evidence': discovery_results['categorized']
})

# 3. Build timeline
timeline_agent = deploy_agent('timeline', config={...})
timeline = execute_agent(timeline_agent, {
    'events': discovery_results['timeline_events']
})

# 4. Check compliance
compliance_agent = deploy_agent('compliance', config={...})
compliance = execute_agent(compliance_agent, {
    'evidence': org_results['structure'],
    'case_type': 'criminal'
})
```

---

## Performance Metrics

| Agent | Speed | Accuracy | Avg. Time |
|-------|-------|----------|-----------|
| Discovery Processor | 100 docs/min | 95% | 10 min (1000 docs) |
| Evidence Organizer | 500 items/min | 98% | 2 min (500 items) |
| Timeline Builder | 200 events/min | 92% | 5 min (200 events) |
| Compliance Checker | 50 items/min | 97% | 10 min (50 items) |

---

## Troubleshooting

**Agent fails to deploy:**
- Check authentication
- Verify agent type spelling
- Review config parameters

**Execution fails:**
- Validate input JSON format
- Check required fields
- Review agent logs

**Low accuracy results:**
- Improve input data quality
- Adjust configuration
- Review sample outputs
- Consider manual review for complex cases

---

## Pricing (Premium Feature)

**Professional Plan ($149/month):**
- 10 agent deployments
- 100 executions/month
- Basic agents (discovery, organizer)

**Enterprise Plan ($349/month):**
- Unlimited agent deployments
- Unlimited executions
- All agents
- Custom agent configuration
- Priority support

---

## Future Agents (Roadmap)

- **Deposition Prep Agent** - Prepare deposition questions
- **Legal Research Agent** - Find case law and statutes
- **Case Strategy Agent** - Analyze strengths/weaknesses
- **Document Drafting Agent** - Generate motions/briefs
- **Expert Witness Matcher** - Find relevant experts
- **Settlement Predictor** - Estimate settlement value

---

**Transform your legal workflow with AI agents today!** 🚀
