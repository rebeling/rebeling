import json

def format_dict_block(d, inline_fields=None):
    lines = []
    for key, value in d.items():
        if isinstance(value, (dict, list)):
            continue  # We'll handle nested separately
        if inline_fields:
            lines.append(f"{key.capitalize()}: {value}  ")
        else:
            lines.append(f"**{key.capitalize()}**: {value}")
    return "\n".join(lines)

def json_to_md(data, level=2):
    md = ""
    prefix = "#" * level

    if isinstance(data, dict):
        for key, value in data.items():
            md += f"\n{prefix} {key.capitalize()}\n\n"
            if isinstance(value, dict):
                md += format_dict_block(value, inline_fields=True) + "\n"
            elif isinstance(value, list):
                for item in value:
                    if isinstance(item, dict):
                        md += format_dict_block(item, inline_fields=True) + "\n\n"
                    else:
                        md += f"{item}\n"
            else:
                md += f"{value}\n"
    else:
        md += str(data)

    return md

# Load resume.json
with open("resume.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# Convert to Markdown
markdown = "# Resume\n" + json_to_md(data)

# Save to output.md
with open("output.md", "w", encoding="utf-8") as f:
    f.write(markdown)

print("✅ Converted to output.md")
