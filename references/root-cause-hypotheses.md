# Root-Cause Hypotheses

Use this when one round of investigation still leaves multiple plausible explanations. The point is to preserve competing explanations in the single file instead of flattening them too soon.

## Hypothesis Grid

Compare at least three explanations:

1. Most likely explanation
2. Plausible alternative
3. Less likely but dangerous explanation

## What To Pull Into The File

- In `Current Context`: system or module background, recent changes, adjacent component context, and prior-state information that makes the hypotheses legible.
- In `Observed Facts`: symptom, failure, contradiction, or traceable event.
- In `Comparisons and Tensions`: the source conflicts or behavioral differences that keep multiple explanations alive.
- In `Hypotheses or Interpretive Angles`: each explanation with support and contradiction side by side.
- In `Open Questions`: what would discriminate between the hypotheses.
- In `Missing Materials`: the highest-value missing evidence.
- In `Inlined Source Materials`: logs and code, plus the system background, config history, ADRs, or change notes needed to understand why the alternatives are plausible.

## Hypothesis Template

```text
Hypothesis:
<explanation>

Support:
- <fact tied to a source>

Contradictions:
- <fact tied to a source>

Why it still matters:
- <why the hypothesis cannot yet be ruled out>
```
