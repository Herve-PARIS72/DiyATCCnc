#!/usr/bin/env python3
"""Recalcule les STL V3 avec OpenSCAD (bibliothèque standard uniquement)."""
import os
from pathlib import Path
import subprocess

root = Path(__file__).resolve().parents[1]
exe = os.environ.get("OPENSCAD", "openscad")
source = root / "cad/ATC_4_douilles_ressorts.scad"
(root / "stl").mkdir(exist_ok=True)
for part in ("bloc", "plaque", "douille", "fond"):
    subprocess.run([exe, "-o", str(root / "stl" / (part + ".stl")),
                    "-D", f'piece="{part}"', str(source)], check=True)
