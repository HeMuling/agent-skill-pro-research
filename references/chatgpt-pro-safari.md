# ChatGPT Pro Through Safari

Use this reference only after `research-context.md` and `pro-prompt.md` exist in the run directory.

## Preconditions

- Use Computer Use to operate Safari. Do not use Oracle, Playwright, browser API automation, or model API mode.
- Confirm the run directory path and the files to send.
- Scan `research-context.md` and `pro-prompt.md` for obvious secrets, credentials, tokens, keys, auth dumps, `.env` content, or unrelated private data.
- Treat uploading or pasting content into ChatGPT as third-party transmission. If the user did not explicitly approve sending this package to ChatGPT Pro in the current request, ask for confirmation immediately before the upload or paste.

## Safari Flow

1. Open or focus Safari with Computer Use.
2. Navigate to ChatGPT.
3. If login, password, 2FA, CAPTCHA, account recovery, or a security challenge appears, stop and ask the user to complete it.
4. Start a new chat unless the user requested a specific existing chat.
5. Select the best available Pro or deep-reasoning model shown in the UI. Do not hardcode a model name; use the strongest Pro/reasoning option visible to the account.
6. Prefer uploading `research-context.md`.
7. Paste the contents of `pro-prompt.md` into the message box.
8. If upload is unavailable, paste the combined content only if the UI accepts it without truncation:
   - First paste `pro-prompt.md`.
   - Then paste a clear separator.
   - Then paste `research-context.md`.
9. Submit only after the intended model and content are visible and correct.

## Waiting

- If ChatGPT is visibly thinking, streaming, or otherwise progressing normally, do not interrupt, restart, click around, or stop because the run is slow.
- Between checks, run `scripts/wait_for_pro_response.sh` from the skill directory or call it by absolute path.
- Repeat sleep and status checks until the final response is complete.
- If the UI shows an error, expired login, unavailable model, upload failure, or a stuck non-progressing state, write the observation to `run-notes.md` and ask the user before changing approach.

## Capturing The Result

- Copy the completed ChatGPT response into `pro-response.md` in the run directory.
- Preserve the response as closely as the UI allows.
- Add a short heading with timestamp and visible model label if available.
- Do not summarize or rewrite the response while saving it.
- If copying from the UI is unreliable, save the best accessible text and note the limitation in `run-notes.md`.
