from datetime import datetime
from html import escape
from pathlib import Path


def _render_diff(diff: str) -> str:
    """
    Render a unified diff as HTML.
    """

    if not diff:
        return "<p>No differences found.</p>"

    lines = []

    for line in diff.splitlines():

        css_class = ""

        if line.startswith("+") and not line.startswith("+++"):
            css_class = "added"

        elif line.startswith("-") and not line.startswith("---"):
            css_class = "removed"

        elif line.startswith("@@"):
            css_class = "hunk"

        lines.append(f'<div class="{css_class}">{escape(line)}</div>')

    return "\n".join(lines)


def generate_html_report(
    comparisons,
    output_dir="report",
    title="SQL Migration Review",
):

    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    summary_rows = []
    detail_sections = []

    for comparison in comparisons:

        name = comparison["name"]

        if comparison["old"]:
            status = "Modified"
            previous = comparison["old"].source_file
        else:
            status = "New"
            previous = "-"

        summary_rows.append(f"""
            <tr>
                <td>{escape(name)}</td>
                <td>{status}</td>
                <td>{escape(previous)}</td>
            </tr>
            """)

        detail_sections.append(f"""
<details>

<summary>{escape(name)}</summary>

<p>

<b>Status:</b> {status}<br>

<b>Previous:</b> {escape(previous)}<br>

<b>Current:</b> {escape(comparison["new"].source_file)}

</p>

<div class="diff">

{_render_diff(comparison["diff"])}

</div>

</details>
""")

    html = f"""
<!DOCTYPE html>

<html>

<head>

<meta charset="utf-8">

<title>{title}</title>

<style>

body {{
    font-family: Arial, Helvetica, sans-serif;
    margin:40px;
    max-width:1200px;
}}

table {{
    border-collapse: collapse;
    width:100%;
}}

th, td {{
    border:1px solid #ddd;
    padding:10px;
}}

th {{
    background:#f5f5f5;
    text-align:left;
}}

details {{
    margin-top:20px;
    border:1px solid #ddd;
    border-radius:6px;
    padding:10px;
}}

summary {{
    cursor:pointer;
    font-weight:bold;
    font-size:16px;
}}

.diff {{
    margin-top:15px;
    background:#fafafa;
    border:1px solid #ddd;
    padding:10px;
    font-family:Consolas, monospace;
    white-space:pre-wrap;
}}

.added {{
    background:#e6ffed;
    color:#22863a;
}}

.removed {{
    background:#ffeef0;
    color:#cb2431;
}}

.hunk {{
    color:#005cc5;
    font-weight:bold;
}}

</style>

</head>

<body>

<h1>{title}</h1>

<p>

Generated:
{datetime.now().strftime("%Y-%m-%d %H:%M:%S")}

</p>

<h2>Summary</h2>

<table>

<tr>

<th>Object</th>

<th>Status</th>

<th>Previous Migration</th>

</tr>

{''.join(summary_rows)}

</table>

<h2>Details</h2>

{''.join(detail_sections)}

</body>

</html>
"""

    report_file = output_path / "index.html"

    report_file.write_text(html, encoding="utf-8")

    return report_file
