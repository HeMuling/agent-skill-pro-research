# Root-Cause Hypotheses

Use this when one round of debugging still leaves multiple plausible explanations.

## Hypothesis Grid

Ask Oracle to compare at least three explanations:

1. Most likely explanation
2. Plausible alternative
3. Less likely but dangerous explanation

## Prompt Skeleton

```text
Task type: root-cause-hypotheses

Observed problem:
<symptom, contradiction, or failure>

Materials map:
- <path>: code
- <path>: config
- <path>: log
- <path>: note or doc

Question:
Compare the most plausible root-cause hypotheses for this problem.

Required output:
- Hypothesis list
- Evidence supporting each hypothesis
- Evidence contradicting each hypothesis
- What evidence is still missing
- Highest-value next check
```
