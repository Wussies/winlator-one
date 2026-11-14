#!/usr/bin/env python3
"""Decide the next tap for tools/emulator-smoke.sh from a uiautomator dump.

usage: emulator-ui.py <ui.xml> [label]   (label defaults to "Install System Files")
Prints "tap-install X Y" for the clickable element labelled <label>,
"tap-dismiss X Y LABEL" for a known system dialog button (old-SDK warning,
permission prompts), or "wait".
"""
import re
import sys
import xml.etree.ElementTree as ET

# Only system dialogs that can cover the wizard; never app content.
DISMISS = {"ok", "allow", "while using the app", "continue"}
DISMISS_PACKAGES = ("android", "com.android.permissioncontroller", "com.google.android.permissioncontroller")


def center(bounds):
    x1, y1, x2, y2 = map(int, re.findall(r"\d+", bounds))
    return (x1 + x2) // 2, (y1 + y2) // 2


def clickable_ancestor(node, parents):
    while node is not None:
        if node.get("clickable") == "true" and node.get("enabled") == "true":
            return node
        node = parents.get(node)
    return None


def main():
    try:
        root = ET.fromstring(open(sys.argv[1], encoding="utf-8", errors="ignore").read().strip() or "<x/>")
    except ET.ParseError:
        print("wait")
        return
    INSTALL = (sys.argv[2] if len(sys.argv) > 2 else "Install System Files").strip().lower()
    parents = {c: p for p in root.iter() for c in p}
    nodes = list(root.iter("node"))

    for n in nodes:
        label = (n.get("text") or "").strip().lower()
        if label in DISMISS and n.get("package", "") in DISMISS_PACKAGES:
            target = clickable_ancestor(n, parents) or n
            x, y = center(target.get("bounds"))
            print(f"tap-dismiss {x} {y} {label.replace(' ', '_')}")
            return

    # The card title and the button share the text; tap the one inside a clickable button.
    candidates = []
    for n in nodes:
        if (n.get("text") or "").strip().lower() == INSTALL or (n.get("content-desc") or "").strip().lower() == INSTALL:
            target = clickable_ancestor(n, parents)
            if target is not None:
                candidates.append(target)
    if candidates:
        x, y = center(candidates[-1].get("bounds"))
        print(f"tap-install {x} {y}")
        return
    print("wait")


if __name__ == "__main__":
    main()
