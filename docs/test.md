# Testing the Templates Component

This component supports multiple testing paths, depending on how much of the stack you want to
exercise.

## Option 1: Unit + Conformance Tests (fast)

Run Rust tests directly.

```bash
cargo test
```

## Option 2: Local component test harness (new)

Use the `greentic-component test` harness to invoke the wasm locally with an in-memory
state/secrets store.

1) Build the wasm:

```bash
greentic-component build --manifest ./component.manifest.json --no-flow --no-write-schema
```

2) Invoke the component with inline JSON:

```bash
target/debug/greentic-component test \
  --wasm target/wasm32-wasip2/release/component_templates.wasm \
  --manifest ./component.manifest.json \
  --op text \
  --input-json '{
    "config": { "templates": { "text": "Hello {{payload.name}}", "output_path": "text" } },
    "msg": {
      "id": "msg-1",
      "tenant": { "env": "dev", "tenant": "default", "tenant_id": "default", "session_id": "s-1", "attempt": 1 },
      "channel": "chat",
      "session_id": "s-1",
      "user_id": null,
      "text": "hello",
      "attachments": [],
      "metadata": {}
    },
    "payload": { "name": "Greentic" }
  }' \
  --pretty
```

Optional flags:
- `--state-dump` to show the in-memory state after the call.
- `--secret KEY=VALUE` or `--secrets .env` to inject secrets.
- `--flow`, `--node`, `--session` to set execution context.

## Option 3: Pack + runner smoke test (full stack)

Build a gtpack and run via the runner CLI to verify end-to-end packaging and execution.

```bash
ci/component_pack_smoke.sh
```
