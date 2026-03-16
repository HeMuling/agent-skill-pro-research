# Second-Opinion Brief

Use this when the user wants a strong external judgment before changing code, locking a conclusion, or writing up results.

## Prompt Skeleton

```text
Task type: second-opinion
Deliverable: structured second-opinion brief

Question:
Give me a high-quality judgment on what is most likely happening, what evidence supports it, and what I should check next.

Materials map:
- <path>: <role>
- <path>: <role>

Constraints:
- Stay grounded in the attached materials
- Separate confirmed findings from plausible hypotheses
- Do not recommend implementation changes unless they follow from the evidence

Required output:
- Best explanation
- Competing hypotheses
- Evidence for and against each
- Confidence and uncertainty
- Next checks or next experiments
```
