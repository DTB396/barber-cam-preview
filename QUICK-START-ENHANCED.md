# Quick Start Guide - Enhanced Analysis System

## Start the Application

### Option 1: Run Flask Development Server
```bash
# Set environment variables
$env:FLASK_APP = "app.py"
$env:FLASK_ENV = "development"

# Run the app
python app.py
```

### Option 2: Direct Python
```bash
python app.py
```

The server will start on http://localhost:5000

## First Time Setup

1. **Create Admin Account**:
   ```bash
   python create_admin.py
   ```

2. **Initialize Database** (if needed):
   ```bash
   python init_database.py
   ```

## Access the Application

### Main Pages
- **Homepage**: http://localhost:5000/
- **Login**: http://localhost:5000/auth/login
- **Dashboard**: http://localhost:5000/dashboard (after login)
- **Upload**: http://localhost:5000/api/upload/video (POST request)

### New Enhanced Features

#### 1. Dashboard with Terminal & Chat
- Navigate to `/dashboard`
- Press **Ctrl+`** to open terminal
- Click chat button to open AI assistant
- Upload videos through the interface

#### 2. Enhanced Analysis Player
After uploading a video:
- Go to `/analysis/<analysis_id>`
- Wait for analysis to complete (mock analysis runs automatically)
- Explore features:
  - **Video Player** with synchronized transcript
  - **Voice Stress Tab** - See stress levels chart
  - **Scenes Tab** - Navigate between detected scenes
  - **Quality Tab** - View audio/video quality metrics
  - **Compliance Tab** - Check legal compliance
  - **Annotations Tab** - Add timestamped notes

#### 3. Terminal Commands
Press **Ctrl+`** anywhere to open terminal:

```bash
# List your analyses
ls

# View analysis details
analyze <analysis-id>

# Download report
download <analysis-id> json
download <analysis-id> txt

# Search (coming soon)
search "officer badge"

# System status
status

# Get help
help
```

#### 4. AI Chat Assistant
- Click chat bubble icon (bottom right)
- Ask questions about your analysis
- Get help with features
- Context-aware responses

## Testing the Enhanced Features

### 1. Upload a Test Video
```bash
curl -X POST http://localhost:5000/api/upload/video \
  -H "Content-Type: multipart/form-data" \
  -F "file=@test_video.mp4" \
  -F "case_number=TEST-001" \
  -F "evidence_number=EV-001" \
  -b cookies.txt
```

### 2. Check Analysis Status
```bash
curl http://localhost:5000/api/analyses \
  -b cookies.txt
```

### 3. Get Enhanced Analysis Data
```bash
curl http://localhost:5000/api/analysis/<id>/enhanced \
  -b cookies.txt
```

### 4. Download Reports
```bash
# JSON format
curl http://localhost:5000/api/analysis/<id>/report/json \
  -b cookies.txt > report.json

# Text format
curl http://localhost:5000/api/analysis/<id>/report/txt \
  -b cookies.txt > report.txt
```

## Keyboard Shortcuts

### Video Player
- **Space** - Play/Pause
- **←/→** - Seek backward/forward 10 seconds
- **↑/↓** - Volume up/down
- **F** - Fullscreen
- **M** - Mute/Unmute
- **1-9** - Playback speed (1=0.5x, 9=2x)

### Terminal
- **Ctrl+`** - Toggle terminal
- **↑/↓** - Command history
- **Tab** - Auto-complete (coming)
- **Ctrl+C** - Cancel command
- **Ctrl+L** - Clear screen

### General
- **Esc** - Close overlays/modals
- **Ctrl+K** - Command palette (coming)
- **?** - Show shortcuts help (coming)

## Features Overview

### Enhanced Analysis Includes:
✅ **Real-time synchronized transcript**
✅ **Audio waveform visualization**
✅ **Voice stress analysis** (stress levels, emotions)
✅ **Automatic scene detection** (8 types)
✅ **Audio quality metrics** (SNR, clarity, distortion)
✅ **Legal compliance checking** (Miranda, chain of custody, etc.)
✅ **Evidence comparison** (cross-reference sources)
✅ **Annotation system** (timestamped notes)
✅ **Interactive timeline** (click to seek)
✅ **Object detection** (in scenes)
✅ **Playback controls** (speed, volume, fullscreen)
✅ **Terminal interface** (CLI commands)
✅ **AI chat assistant** (context-aware help)

### Analysis Tools Tabs:
1. **Voice Stress** - Real-time stress chart, high stress moments
2. **Scenes** - Detected scenes with timestamps and characteristics
3. **Quality** - Audio/video quality assessment
4. **Compliance** - Legal standards verification
5. **Annotations** - Add and manage timestamped notes

## Example Workflow

1. **Login** to dashboard
2. **Upload** a BWC video (MP4, MOV, AVI, WEBM)
3. **Wait** for analysis (progress shown)
4. **View** enhanced analysis page
5. **Watch** video with synchronized transcript
6. **Review** voice stress patterns
7. **Navigate** through detected scenes
8. **Check** compliance status
9. **Add** annotations at key moments
10. **Download** reports (JSON, TXT, MD)
11. **Use terminal** for quick commands
12. **Ask AI** for help or insights

## Troubleshooting

### App won't start
- Check Python version: `python --version` (need 3.7+)
- Install dependencies: `pip install -r requirements.txt`
- Check database: `python init_database.py`

### Video won't play
- Ensure browser supports H.264 codec
- Try different video format (MP4 recommended)
- Check file size limits in .env

### Analysis stuck
- Refresh page to check status
- Check logs: Look for errors in terminal
- Restart analysis: Delete and re-upload

### Terminal won't open
- Press **Ctrl+`** (backtick, not apostrophe)
- Check JavaScript console for errors
- Try refreshing page

### Chat not responding
- Check /api/chat endpoint is working
- Verify you're logged in
- Check network tab for errors

## Environment Variables

```bash
# .env file
DATABASE_URL=sqlite:///barberx_FRESH.db  # or PostgreSQL URL
SECRET_KEY=your-secret-key-here
UPLOAD_FOLDER=./uploads/bwc_videos
ANALYSIS_FOLDER=./bwc_analysis
MAX_UPLOAD_SIZE=500000000  # 500MB
OPENAI_API_KEY=your-key  # for real AI chat
```

## Development Tips

### Enable Debug Mode
```python
# app.py
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
```

### View Database
```bash
# SQLite
sqlite3 barberx_FRESH.db
.tables
SELECT * FROM analyses;
```

### Check Logs
```bash
# Terminal output shows:
# - Request logs
# - Analysis progress
# - Error messages
```

### Test Enhanced Analysis
```bash
# Generate test analysis
python -c "from enhanced_analysis_tools import advanced_analyzer; print(advanced_analyzer.generate_complete_analysis('test.mp4'))"
```

## Production Deployment

1. Set `FLASK_ENV=production`
2. Use PostgreSQL database
3. Enable HTTPS
4. Set strong SECRET_KEY
5. Configure file storage (S3, etc.)
6. Set up reverse proxy (Nginx)
7. Use production WSGI server (Gunicorn)

## Next Steps

- Add real AI (Whisper, spaCy, OpenAI)
- Implement multi-source sync
- Add collaboration features
- Create mobile app
- Build redaction tools
- Add live streaming support

## Support

- Documentation: `/docs`
- Issues: GitHub Issues
- Chat: Use AI assistant in app
- Terminal: Type `help` for commands

---

**BarberX Legal Tech Enhanced Analysis System**
Version 2.0 - Fully Integrated
