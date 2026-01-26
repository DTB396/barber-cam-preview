# BarberX Evidence Processor - Quick Reference

## 🚀 Getting Started

```bash
# Start the application
python app.py

# Access points
http://localhost:5000/evidence/intake      # Submit new evidence
http://localhost:5000/evidence/dashboard   # Processing dashboard
http://localhost:5000/dashboard            # Main dashboard
```

## 📋 Evidence Submission Workflow

1. **Navigate** to `/evidence/intake`
2. **Complete 5 sections**:
   - Case Information
   - Evidence Upload
   - Evidence Details
   - Acquisition Info
   - Processing Instructions
3. **Upload files** (drag-drop or click)
4. **Wait for hash** calculation (automatic)
5. **Submit** - Evidence ID generated

## 🔄 7-Stage Processing Pipeline

```
1. INTAKE       → Evidence logged, hash calculated
2. VERIFICATION → Integrity check, format validation
3. METADATA     → Extract EXIF, timestamps, device info
4. ANALYSIS     → Transcript, speakers, entities, timeline
5. ENHANCEMENT  → Voice stress, scenes, quality, compliance
6. REVIEW       → Accuracy check, QA, legal review
7. APPROVED     → Court-ready, exhibit generation
```

## ⏰ Priority Levels & SLAs

| Priority | SLA      | When to Use |
|----------|----------|-------------|
| 🔴 Critical | 4 hours  | Active investigations, urgent court deadlines |
| 🟠 High     | 24 hours | Important cases, upcoming trials |
| 🔵 Normal   | 72 hours | Standard processing |
| ⚪ Low      | 7 days   | Background research, cold cases |

## 🎯 Dashboard Features

### Statistics Cards
- **Total Evidence** - All items in system
- **In Processing** - Currently being analyzed
- **Completed** - Ready for court
- **SLA At Risk** - Need attention

### Pipeline View
- Visual 7-stage workflow
- Item counts per stage
- Click to filter by stage

### Evidence Table
- Evidence ID (unique)
- Case number
- Current stage
- Priority level
- SLA countdown
- Quick actions

### Filters
- All | Critical | Overdue | Assigned to Me

## ⌨️ Terminal Commands

```bash
# Evidence management
evidence list                    # List all evidence
evidence view <id>              # View details
evidence status <id>            # Check processing status
evidence custody <id>           # View chain of custody
evidence advance <id>           # Move to next stage
evidence exhibit <id> <ex-num>  # Generate court exhibit

# Analysis shortcuts
ls                              # List analyses
analyze <id>                    # View analysis details
download <id> json              # Download report

# System
status                          # System health
help                           # Show all commands
```

## 🔐 Chain of Custody

### Automatically Tracked Events
- Evidence received
- Stage advancements
- File access
- Analyst assignments
- Notes added
- Reports generated
- Exhibit creation

### Each Event Includes
- Timestamp (UTC)
- Event type
- Actor (who)
- Details (what)
- Location (where)
- Verification hash

### Integrity Verification
```python
# System validates:
- Timeline consistency (no gaps)
- Hash verification
- Actor authorization
- Complete audit trail
```

## 📄 Court-Ready Exhibits

### Generated Package Includes
1. **Evidence file** (original, hash-verified)
2. **Transcript PDF** (complete with timestamps)
3. **Analysis report PDF** (comprehensive findings)
4. **Chain of custody PDF** (complete timeline)
5. **Technical specs PDF** (file details, metadata)
6. **Examiner certification** (professional statement)

### Exhibit Numbering
- Format: EX-001, EX-002, etc.
- Linked to case number
- Unique identifier
- Court-friendly naming

## 🛠️ Processing Checklists

### Intake Stage Tasks
- [ ] Verify submitter identity
- [ ] Log evidence in system
- [ ] Calculate SHA-256 hash
- [ ] Capture initial metadata

### Verification Stage Tasks
- [ ] Verify file integrity (hash check)
- [ ] Verify format and playability
- [ ] Check for duplicate evidence
- [ ] Initial quality assessment

### Analysis Stage Tasks
- [ ] Generate transcript
- [ ] Identify speakers
- [ ] Extract entities (persons, locations)
- [ ] Create timeline of events

### Enhancement Stage Tasks
- [ ] Voice stress analysis
- [ ] Scene detection
- [ ] Audio/video quality metrics
- [ ] Legal compliance verification

### Review Stage Tasks
- [ ] Review transcript accuracy
- [ ] Verify completeness
- [ ] Quality assurance review
- [ ] Legal review for admissibility

## 🎨 UI Elements

### Stage Badges
- **Intake** - Blue
- **Verification** - Light Blue
- **Analysis** - Yellow
- **Review** - Orange
- **Approved** - Green

### Priority Indicators
- 🔴 Critical - Red dot
- 🟠 High - Orange dot
- 🔵 Normal - Blue dot
- ⚪ Low - Gray dot

### SLA Timers
- **On Track** - Green (> 4h remaining)
- **At Risk** - Yellow (< 4h remaining)
- **Overdue** - Red (deadline passed)

## 🔧 Configuration

### Environment Variables
```bash
UPLOAD_FOLDER=./uploads/evidence
ANALYSIS_FOLDER=./bwc_analysis
MAX_UPLOAD_SIZE=500000000  # 500MB
SLA_EMAIL_ALERTS=true
SLA_ESCALATION_HOURS=4
```

### Supported File Types
- **Video**: MP4, MOV, AVI, WEBM
- **Audio**: MP3, WAV, M4A
- **Documents**: PDF
- **Images**: JPG, PNG

## 📊 Workflow Best Practices

### For Investigators
1. Submit evidence ASAP after acquisition
2. Set appropriate priority level
3. Include detailed descriptions
4. Tag related evidence
5. Track SLA deadlines
6. Download exhibits before court

### For Analysts
1. Check dashboard daily for new items
2. Focus on critical/overdue first
3. Complete all checklist tasks
4. Add notes for context
5. Review thoroughly before advancing
6. Verify hash before final approval

### For Supervisors
1. Monitor pipeline flow
2. Watch SLA timers
3. Reassign overloaded analysts
4. Spot-check quality
5. Review before court submission
6. Generate performance reports

## ⚡ Keyboard Shortcuts

- **Ctrl+`** - Toggle terminal
- **Space** - Play/pause video (in player)
- **←/→** - Navigate timeline
- **F** - Fullscreen
- **Esc** - Close overlays

## 📞 Support

### Documentation
- `EVIDENCE-PROCESSING-SYSTEM.md` - Complete guide
- `BEST-EVIDENCE-PROCESSOR.md` - Feature overview
- `QUICK-START-ENHANCED.md` - User guide

### Help Resources
- Terminal: Type `help`
- AI Chat: Click chat button
- Dashboard: Hover for tooltips

## ✅ Quality Assurance

### Before Submitting to Court
- [ ] Evidence hash verified
- [ ] Chain of custody complete
- [ ] All stages completed
- [ ] Legal review passed
- [ ] Exhibits generated
- [ ] Files accessible
- [ ] Documentation complete

### Red Flags (Do Not Submit)
- ❌ Hash mismatch
- ❌ Gaps in chain of custody
- ❌ Incomplete analysis
- ❌ Failed quality checks
- ❌ Missing metadata
- ❌ No legal review

## 🚨 Common Issues

### Evidence won't upload
- Check file size (< 500MB)
- Verify file type supported
- Check internet connection
- Try different browser

### Hash calculation stuck
- Large files take longer (wait)
- Refresh if > 2 minutes
- Contact support if persists

### Can't advance stage
- Complete all required tasks
- Check user permissions
- Verify no errors in analysis
- Contact supervisor

## 📈 Success Metrics

Track these KPIs:
- Evidence processed per week
- Average processing time
- SLA compliance rate
- Court acceptance rate
- Quality score
- Analyst efficiency

---

**Quick Start**: Upload evidence → Monitor dashboard → Download exhibits  
**Goal**: Professional, court-admissible evidence processing  
**Result**: The best evidence processor for legal teams 🏆
