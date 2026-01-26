# Analysis & Transcription Fix Plan

## Issues Identified

### Backend Issues
1. ❌ BWC analyzer not initialized (AI dependencies not installed)
2. ❌ Video upload route placeholder - no transcription integration
3. ❌ PDF/DOCX export needs reportlab/python-docx dependencies
4. ❌ No real-time analysis status updates (WebSocket/polling needed)

### Frontend Issues  
1. ❌ Batch processing is client-side simulation only
2. ❌ No actual API integration for batch uploads
3. ❌ Timeline export shows alerts instead of downloading files
4. ❌ No visual feedback for analysis progress
5. ❌ No transcript display on results pages
6. ❌ Dashboard shows placeholder data, not real analysis results

### UX Issues
1. ❌ No loading states during analysis
2. ❌ No error handling for failed analyses
3. ❌ No way to view transcripts inline
4. ❌ No speaker labels in transcript view
5. ❌ No timeline visualization
6. ❌ No discrepancy highlighting

## Fix Strategy

### Phase 1: Backend Fixes (Without AI Dependencies)
- [ ] Create mock analysis results generator
- [ ] Fix video upload to create proper analysis records
- [ ] Add simple text extraction (no AI needed)
- [ ] Implement report generation (JSON/TXT/MD)
- [ ] Add analysis status polling endpoint

### Phase 2: Frontend Integration
- [ ] Connect batch upload to actual API
- [ ] Add real-time progress indicators
- [ ] Create transcript viewer component
- [ ] Add timeline visualization
- [ ] Implement report download

### Phase 3: UX Improvements
- [ ] Add loading spinners
- [ ] Show analysis progress
- [ ] Display transcripts with timestamps
- [ ] Highlight speakers
- [ ] Show discrepancies
- [ ] Add error states

### Phase 4: Optional AI Integration (If dependencies available)
- [ ] Check for Whisper availability
- [ ] Enable real transcription if available
- [ ] Use mock data as fallback

## Implementation Order

1. ✅ Create mock analysis generator (for testing without AI)
2. ✅ Fix video upload endpoint
3. ✅ Add analysis polling endpoint
4. ✅ Create transcript viewer component
5. ✅ Fix batch upload integration
6. ✅ Add progress indicators
7. ✅ Implement report downloads
8. ✅ Add timeline visualization
9. ✅ Improve dashboard with real data
