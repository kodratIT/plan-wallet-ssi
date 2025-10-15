# Diagram Testing Guide

## Error Fixed

✅ **Fixed errors in:**
- `03-pin-recovery-flow.puml` - Removed unnecessary C4_Component include
- `04-biometric-flow.puml` - Removed unnecessary C4_Component include

These are sequence diagrams and don't need C4 includes.

## How to Test Diagrams

### Option 1: Online (Recommended)
1. Go to: https://www.plantuml.com/plantuml/uml/
2. Copy content dari file .puml
3. Paste di online editor
4. Click "Submit" untuk generate diagram

### Option 2: VS Code Extension
1. Install extension: "PlantUML" by jebbs
2. Open file .puml
3. Press `Alt+D` (Mac: `Option+D`) untuk preview
4. Or Right-click → "Preview Current Diagram"

### Option 3: Install PlantUML CLI
```bash
# macOS
brew install plantuml

# Then generate PNG
plantuml *.puml

# Or generate SVG
plantuml -tsvg *.puml
```

## Diagram Files

1. `01-security-context.puml` - C4 Context diagram (uses C4_Context.puml) ✅
2. `02-security-architecture.puml` - C4 Container diagram (uses C4_Container.puml) ✅
3. `03-pin-recovery-flow.puml` - Sequence diagram (no C4 include) ✅ FIXED
4. `04-biometric-flow.puml` - Sequence diagram (no C4 include) ✅ FIXED

All diagrams should now render without errors!
