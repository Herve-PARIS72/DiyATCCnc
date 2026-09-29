#!/usr/bin/env python3
"""Contrôle limité : STL ASCII non vide, arêtes partagées par deux triangles."""
from collections import Counter
from pathlib import Path

root = Path(__file__).resolve().parents[1]
for path in sorted((root / "stl").glob("*.stl")):
    vertices = [tuple(map(float, line.split()[1:]))
                for line in path.read_text().splitlines()
                if line.strip().startswith("vertex ")]
    if not vertices or len(vertices) % 3:
        raise ValueError(f"STL ASCII invalide ou vide : {path}")
    edges = Counter()
    for offset in range(0, len(vertices), 3):
        tri = vertices[offset:offset + 3]
        if len(set(tri)) != 3:
            raise ValueError(f"Triangle dégénéré : {path}")
        for i in range(3):
            edges[tuple(sorted((tri[i], tri[(i + 1) % 3])))] += 1
    if any(count != 2 for count in edges.values()):
        raise ValueError(f"Arêtes ouvertes ou non-manifold : {path}")
    size = [round(max(v[i] for v in vertices)-min(v[i] for v in vertices), 3)
            for i in range(3)]
    print(f"{path.name}: {len(vertices)//3} triangles, arêtes fermées, dimensions {size} mm")
