# Second-Opinion Brief

Use this when the user wants a judgment-oriented package before changing code, locking a conclusion, or writing up results. The goal is to assemble the materials and shape `pro-prompt.md` so ChatGPT Pro can reach a strong second opinion from the attached or pasted `research-context.md`.

## What To Emphasize

- The sharpest statement of the question in `Task Purpose`
- The most decision-relevant evidence high in `Observed Facts`
- The strongest conflicts in `Comparisons and Tensions`
- The prior decisions, surrounding documentation, and competing narratives that affect how the evidence should be read
- Clear separation between confirmed evidence and interpretive angles
- A realistic accounting of confidence limits in `Open Questions` and `Missing Materials`

## Judgment-Oriented Checklist

- Include the primary evidence first, not commentary about the evidence.
- Include prior explanations only if they affect how the reader should evaluate the current materials.
- Include the surrounding docs a reviewer would need to evaluate the case without reconstructing the broader context.
- Preserve counter-evidence even when it weakens the preferred story.
- Inline the specific passages, decision notes, and background references that a downstream reviewer would want to inspect directly.

## Pro Prompt Shape

Use this shape for `pro-prompt.md`:

```text
Deliverable:
Provide an evidence-grounded second opinion for the question below.

Core question:
<one exact question>

Decision to unblock:
<what this answer should help decide>

Instructions:
- Use the attached or pasted `research-context.md` as the evidence base.
- Separate confirmed facts from interpretation.
- Compare competing explanations and state confidence.
- Cite the relevant source names or sections from the package.
- Identify missing evidence and concrete next checks.
- Do not assume facts that are not in the package.
```

Keep `research-context.md` self-contained even when `pro-prompt.md` is present. The Pro prompt should direct the model's task, not replace the evidence package.
