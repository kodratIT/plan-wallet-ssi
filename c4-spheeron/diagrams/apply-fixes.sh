#!/bin/bash

# Script to backup original files and apply fixes
# Created to fix PlantUML build errors in component diagrams 06-13

DIAGRAM_DIR="/Users/kodrat/Public/Penelitian/uml/c4-spheeron/diagrams"
BACKUP_DIR="$DIAGRAM_DIR/backup-$(date +%Y%m%d-%H%M%S)"

echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Backup and replace files
for i in 06 07 08 09 10 11 12 13; do
    ORIGINAL_FILE="$DIAGRAM_DIR/${i}-component-*.puml"
    FIXED_FILE=$(ls $DIAGRAM_DIR/${i}-*-fixed.puml 2>/dev/null | head -1)
    ORIGINAL_FILE=$(ls $DIAGRAM_DIR/${i}-component-*.puml 2>/dev/null | grep -v fixed | head -1)
    
    if [ -f "$ORIGINAL_FILE" ] && [ -f "$FIXED_FILE" ]; then
        echo "Processing file $i..."
        echo "  Original: $ORIGINAL_FILE"
        echo "  Fixed: $FIXED_FILE"
        
        # Backup original
        cp "$ORIGINAL_FILE" "$BACKUP_DIR/"
        echo "  ✓ Backed up to $BACKUP_DIR/"
        
        # Replace with fixed version
        cp "$FIXED_FILE" "$ORIGINAL_FILE"
        echo "  ✓ Replaced with fixed version"
        echo ""
    else
        echo "⚠ Warning: Could not find files for component $i"
        echo ""
    fi
done

echo "========================================="
echo "Backup and replacement completed!"
echo "Original files backed up to: $BACKUP_DIR"
echo "========================================="
echo ""
echo "To verify the fixes, try building the diagrams with PlantUML:"
echo "  plantuml $DIAGRAM_DIR/*.puml"
echo ""
echo "To rollback if needed:"
echo "  cp $BACKUP_DIR/*.puml $DIAGRAM_DIR/"
