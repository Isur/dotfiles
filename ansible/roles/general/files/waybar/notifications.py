#!/usr/bin/env python3
import json
import re
import subprocess
import sys


def main() -> int:
    max_items = 5
    if len(sys.argv) > 1:
        try:
            max_items = int(sys.argv[1])
        except ValueError:
            max_items = 5

    try:
        result = subprocess.run(
            ["makoctl", "history"],
            check=False,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True,
        )
        text = result.stdout
    except FileNotFoundError:
        text = ""

    titles = []
    for line in text.splitlines():
        match = re.match(r"^Notification\s+\d+:\s*(.*)$", line)
        if match:
            titles.append(match.group(1).strip())

    titles = titles[:max_items]
    count = len(titles)

    if count == 0:
        payload = {
            "text": "󰍡 0",
            "tooltip": "No notifications",
        }
    else:
        tooltip = "\n".join(f"{idx + 1}. {title}" for idx, title in enumerate(titles))
        payload = {
            "text": f"󰍡 {count}",
            "tooltip": tooltip,
        }

    print(json.dumps(payload))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
